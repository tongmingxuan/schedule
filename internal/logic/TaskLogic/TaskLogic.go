package TaskLogic

import (
	"Schedule/internal/common"
	"Schedule/internal/consts"
	"Schedule/internal/dao"
	"Schedule/internal/logic/BaseLogic"
	"Schedule/internal/logic/RedisLogic"
	"Schedule/internal/logic/RequestLogic"
	"Schedule/internal/model/entity"
	"context"
	"encoding/json"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/gconv"
	"github.com/gogf/gf/v2/util/guid"
	"time"
)

var (
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
	// ConstRunMaxRetry 到达最大运行次数
	ConstRunMaxRetry = 5
	// ConstRunningError 任务存在异常
	ConstRunningError = 6
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
func (logic TaskLogic) CreateTask(ctx context.Context, routeInfo entity.Route, param interface{}, traceId string, mainTraceId string, delay int) PretreatmentResp {
	data := g.Map{
		"main_trace_id": mainTraceId,
		"trace_id":      traceId,
		"param":         param,
		"status":        ConstWaitingRun,
		"route_id":      routeInfo.Id,
		"push_url":      routeInfo.PushUrl,
		"delay":         delay,
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
	lockValue := guid.S()

	redis := RedisLogic.InitRedis(ctx)

	defer func() {
		redis.ReleaseLock(traceId, lockValue)
	}()

	redis.Lock(traceId, lockValue, 8, 15)

	taskInfo := logic.Find(ctx, g.Map{"trace_id": traceId})

	common.LoggerInfo(ctx, "finish:查询task数据:trace_id:"+traceId, taskInfo)

	defer func() {
		if r := recover(); r != nil {
			common.LoggerInfo(ctx, "finish:出现异常:trace_id:"+traceId, g.Map{"error": r})

			if traceId != "" && taskInfo.Status != ConstCancel && taskInfo.Status != ConstRunMaxRetry {
				logic.Update(ctx, g.Map{"trace_id": traceId}, g.Map{"status": ConstRunningError, "result": r})
			}

			panic(r)
		}

		common.LoggerInfo(ctx, "finish:运行结束:trace_id:"+traceId, nil)
	}()

	if taskInfo.Id == 0 {
		panic("任务不存在:trace_id:" + traceId)
	}

	if taskInfo.Status == ConstCancel {
		panic("当前任务已作废:trace_id:" + traceId)
	}

	if taskInfo.Status == ConstRunMaxRetry {
		panic("当前任务已到达最大运行次数:trace_id:" + traceId)
	}

	if taskInfo.Status == ConstRunSuccess {
		return FinishResp{TraceId: traceId, Message: "幂等:已finish成功:任务全部结束"}
	}

	if taskInfo.Status == ConstFinishSuccess {
		return FinishResp{TraceId: traceId, Message: "幂等:已finish成功"}
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

		common.LoggerInfo(ctx, "finish:获取数量:trace_id:"+traceId, g.Map{
			"total_count":   totalCount,
			"success_count": successCount,
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

	score := time.Now().Unix()

	if taskInfo.Delay > 0 {
		score = score + int64(taskInfo.Delay)
	}

	logic.AddFinishSortedSet(ctx, taskInfo.RouteId, score, taskInfo.TraceId)
}

func (logic TaskLogic) LockName(traceId string) string {
	return "lock_task_trace_id" + traceId
}

// CallFinishApi
// @Description: 推送Finish-Api
// @receiver logic
// @param traceId
// @param routeInfo
func (logic TaskLogic) CallFinishApi(ctx context.Context, traceId string, routeInfo entity.Route) {

	ctx = context.WithValue(ctx, consts.CtxTraceId, traceId)

	prefix := "CallFinishApi:trace_id:" + traceId + ":route_name:" + routeInfo.Name + ":"

	common.LoggerInfo(ctx, prefix+"接收到数据", g.Map{
		"trace_id": traceId,
		"route":    routeInfo,
	})

	redis := RedisLogic.InitRedis(ctx)

	defer func() {
		if r := recover(); r != nil {
			common.LoggerInfo(ctx, prefix+"发送异常:error", g.Map{
				"error":    r,
				"trace_id": traceId,
			})

			jsonData, jsonErr := json.Marshal(g.Map{"err": r})

			errorString := ""

			if jsonErr != nil {
				errorString = "运行异常:捕获异常json失败:" + jsonErr.Error()
			} else {
				errorString = string(jsonData)
			}

			logic.Update(ctx, g.Map{"trace_id": traceId}, g.Map{
				"status": ConstRunningError,
				"result": errorString,
			})

		}
	}()

	task := logic.Find(ctx, g.Map{"trace_id": traceId})

	common.LoggerInfo(ctx, prefix+"查询任务信息", g.Map{"task": task})

	//  finish调用成功
	if task.Status == ConstFinishSuccess {
		common.LoggerInfo(ctx, prefix+"任务已经调用finish成功", nil)

		redis.DeleteSortedMember(logic.FinishSetName(routeInfo.Id), traceId)

		common.LoggerInfo(ctx, prefix+"在集合中删除该元素", nil)

		return
	}

	//  全部任务运行成功
	if task.Status == ConstRunSuccess {
		common.LoggerInfo(ctx, prefix+"任务已经任务全部运行成功", nil)

		redis.DeleteSortedMember(logic.FinishSetName(routeInfo.Id), traceId)

		common.LoggerInfo(ctx, prefix+"在集合中删除该元素", nil)

		return
	}

	//  任务作废
	if task.Status == ConstRunMaxRetry {
		common.LoggerInfo(ctx, prefix+"任务已经作废", nil)

		redis.DeleteSortedMember(logic.FinishSetName(routeInfo.Id), traceId)

		common.LoggerInfo(ctx, prefix+"在集合中删除该元素", nil)

		return
	}

	runCount := task.Count + 1

	if runCount > 10 {
		common.LoggerInfo(ctx, prefix+"任务运行超过10次", nil)

		logic.Update(ctx, g.Map{"trace_id": traceId}, g.Map{"status": ConstRunMaxRetry})

		//todo 假如子任务超过运行次数则修改主任务超时

		//RedisLogic.Redis{}.DeleteSortedMember(logic.FinishSetName(routeInfo.Id), traceId)
		redis.DeleteSortedMember(logic.FinishSetName(routeInfo.Id), traceId)

		return
	}

	req := g.Map{
		"main_trace_id": task.MainTraceId,
		"trace_id":      task.TraceId,
		"route_name":    routeInfo.Name,
		"param":         task.Param,
	}

	common.LoggerInfo(ctx, prefix+"组织请求数据", req)

	jsonReq, jsonErr := json.Marshal(req)

	if jsonErr != nil {
		panic("json请求参数异常:" + jsonErr.Error())
	}

	logic.Update(ctx, g.Map{"trace_id": traceId}, g.Map{"count": runCount, "request_param": jsonReq})

	response := RequestLogic.Request{}.Post(ctx, task.PushUrl, req)

	logic.Update(ctx, g.Map{"trace_id": traceId}, g.Map{"result": response})

}
