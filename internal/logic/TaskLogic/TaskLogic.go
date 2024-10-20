package TaskLogic

import (
	"Schedule/internal/consts"
	"Schedule/internal/dao"
	"Schedule/internal/logic/BaseLogic"
	"Schedule/internal/model/entity"
	"context"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/gconv"
)

var (
	// CONST_TASK_STATUS_0 待调度
	CONST_TASK_STATUS_0 = 0
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
		"status":        CONST_TASK_STATUS_0,
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

// Confirm
// @Description: 确认并投递
// @receiver logic
// @param ctx
// @param taskInfo
func (logic TaskLogic) Confirm(ctx context.Context, taskInfo entity.Task) {

}

func (logic TaskLogic) PushConfirmSortSet(ctx context.Context, taskInfo entity.Task) {

}
