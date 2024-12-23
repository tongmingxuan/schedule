package TaskLogic

import (
	"Schedule/internal/consts"
	"Schedule/internal/dao"
	"Schedule/internal/logic/BaseLogic"
	"Schedule/internal/logic/RedisLogic"
	"Schedule/internal/model/entity"
	"context"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/gconv"
	"time"
)

var (
	// CONST_TASK_STATUS_1 已投递
	CONST_TASK_STATUS_1 = 1
	// CONST_TASK_STATUS_2 已接收finish
	CONST_TASK_STATUS_2 = 2
	// CONST_TASK_STATUS_3 子任务生成成功
	CONST_TASK_STATUS_3 = 3
	// CONST_TASK_STATUS_4 运行成功
	CONST_TASK_STATUS_4 = 4
	// CONST_TASK_STATUS_5 运行异常
	CONST_TASK_STATUS_5 = 5
	// CONST_TASK_STATUS_6 作废
	CONST_TASK_STATUS_6 = 6

	// ConstWaitingRun 待运行
	ConstWaitingRun = 0
	// ConstAlreadyPushFinish 已投递finish集合
	ConstAlreadyPushFinish = 1
	// ConstFinishSuccess finish调用成功
	ConstFinishSuccess = 2
	// ConstCancel 作废
	ConstCancel = 3
	// ConstRunSuccess 任务全部运行
	ConstRunSuccess = 4
)

type TaskLogic struct {
	BaseLogic.BaseLogic
}

func (logic TaskLogic) GetDao(ctx context.Context) *gdb.Model {
	return dao.Task.Ctx(ctx)
}

// ConfirmSetName
// @Description: confirm集合名称
// @receiver logic
// @param routeId
// @return string
func (logic TaskLogic) ConfirmSetName(routeId int) string {
	return consts.ConfirmSetName + gconv.String(routeId)
}

// FinishSetName
// @Description: finish集合名称
// @receiver logic
// @param routeId
// @return string
func (logic TaskLogic) FinishSetName(routeId int) string {
	return consts.FinishSetName + gconv.String(routeId)
}

// CreateTask
// @Description: 创建任务
// @receiver logic
// @param ctx
// @param routeInfo 路由信息
// @param param 投递参数
// @param traceId 任务ID
// @param mainTraceId 主任务ID
// @return PretreatmentResp
func (logic TaskLogic) CreateTask(ctx context.Context, routeInfo entity.Route, param interface{}, traceId string, mainTraceId string) PretreatmentResp {
	data := g.Map{
		"main_trace_id": mainTraceId,
		"trace_id":      traceId,
		"param":         param,
		"status":        ConstWaitingRun,
		"route_id":      routeInfo.Id,
		"push_url":      routeInfo.PushUrl,
	}

	return PretreatmentResp{
		TraceId:   traceId,
		RouteName: routeInfo.Name,
		RouteId:   routeInfo.Id,
		TaskId:    logic.Insert(logic.GetDao(ctx), data),
	}
}

func (logic TaskLogic) Find(ctx context.Context, where interface{}) entity.Task {
	var taskInfo entity.Task

	result := logic.FindInfoByWhere(logic.GetDao(ctx), where)

	if len(result.Map()) == 0 {
		return taskInfo
	}

	err := result.Struct(&taskInfo)

	if err != nil {
		panic("taskLogic:find:error:" + err.Error())
	}

	return taskInfo
}

func (logic TaskLogic) Update(ctx context.Context, where interface{}, update interface{}) int {
	return logic.UpdateByWhere(logic.GetDao(ctx), where, update)
}

func (logic TaskLogic) GetList(ctx context.Context, where interface{}, field interface{}) []entity.Task {
	list := logic.GetListByWhere(logic.GetDao(ctx), where, field)

	var result []entity.Task

	if err := list.Structs(&result); err != nil {
		panic("转化异常")
	}

	return result
}

// AddFinishSortedSet
// @Description: 设置finish有序集合
// @receiver logic
// @param ctx
// @param routeId
// @param score
// @param member
func (logic TaskLogic) AddFinishSortedSet(ctx context.Context, routeId int, score int64, member string) {
	sortedSetName := logic.FinishSetName(routeId)

	RedisLogic.InitRedis(ctx).AddSortedSet(sortedSetName, score, member)
}

// CreateKeyMap
// @Description: 创建字典表数据
// @receiver logic
// @param ctx
// @param keyMap 字典配置 map类型
// @param taskId 任务ID 当前任务与字典内容关联
func (logic TaskLogic) CreateKeyMap(ctx context.Context, keyMap g.Map, taskId int) {
	if len(keyMap) == 0 {
		return
	}

	for key, value := range keyMap {
		_, err := dao.Keymap.Ctx(ctx).Insert(g.Map{
			"key":        key,
			"value":      value,
			"task_id":    taskId,
			"created_at": time.Now().Format("2006-01-02 15:04:05"),
		})

		if err != nil {
			panic("创建keyMap异常:" + err.Error())
		}
	}
}

// Finish
// @Description: 接收finish 投递子任务 或者 终结所有任务
// @receiver logic
// @param ctx
// @param traceId 当前任务的任务ID
// @param keyMap  finish对应的字典
// @param param   finish传递的参数 写入到子任务的param中投递子任务消息时携带这个param
// @return FinishResp
func (logic TaskLogic) Finish(ctx context.Context, traceId string, keyMap g.Map, param g.Map) FinishResp {
	taskInfo := logic.Find(ctx, g.Map{"trace_id": traceId})

	if taskInfo.Id == 0 {
		panic("任务不存在:trace_id:" + traceId)
	}

	if taskInfo.Status == ConstFinishSuccess {
		return FinishResp{TraceId: traceId, Message: "幂等:已finish成功"}
	}

	if taskInfo.Status != ConstAlreadyPushFinish {
		panic("任务状态不为已投递finish集合:trace_id:" + traceId)
	}

	err := g.DB().Transaction(ctx, func(ctx context.Context, tx gdb.TX) error {
		logic.CreateKeyMap(ctx, keyMap, taskInfo.Id)

		logic.Update(ctx, g.Map{"trace_id": traceId}, g.Map{
			"status": ConstFinishSuccess,
		})

		//判断全部任务是否结束
		totalCount, err := logic.GetDao(ctx).Count(g.Map{"main_trace_id": taskInfo.MainTraceId, "status !=": ConstCancel})

		if err != nil {
			return err
		}

		successCount, err := logic.GetDao(ctx).Count(g.Map{
			"main_trace_id": taskInfo.MainTraceId,
			"status !=":     ConstCancel,
			"status":        ConstFinishSuccess,
		})

		if err != nil {
			return err
		}

		if totalCount == successCount {
			logic.Update(ctx, g.Map{"main_trace_id": taskInfo.MainTraceId}, g.Map{
				"status": ConstRunSuccess,
			})

			return nil
		}

		//判断是否存在子任务 如果存在子任务则投递子任务到finish
		field := []string{"id", "route_id", "trace_id"}

		child := logic.GetList(ctx, g.Map{"parent_id": taskInfo.Id}, field)

		if len(child) > 0 {
			for _, childTask := range child {
				logic.ToFinishSortedSet(ctx, childTask, param)
			}
		}

		return nil
	})

	if err != nil {
		panic("操作异常:trace_id:" + traceId + ":error:" + err.Error())
	}

	return FinishResp{TraceId: traceId, Message: "finish:success"}
}

// ToFinishSortedSet
// @Description: 推送finish集合 且 更新状态
// @receiver logic
// @param ctx
// @param taskInfo 任务信息
// @param param 任务投递的参数
func (logic TaskLogic) ToFinishSortedSet(ctx context.Context, taskInfo entity.Task, param interface{}) {
	childUpdate := g.Map{
		"status": ConstAlreadyPushFinish,
	}

	if param != nil {
		childUpdate["param"] = param
	}

	logic.Update(ctx, g.Map{"id": taskInfo.Id}, childUpdate)
	logic.AddFinishSortedSet(ctx, taskInfo.RouteId, time.Now().Unix(), taskInfo.TraceId)
}

func (logic TaskLogic) LockName(traceId string) string {
	return "lock_task_trace_id" + traceId
}
