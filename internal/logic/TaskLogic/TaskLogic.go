package TaskLogic

import (
	"Schedule/internal/dao"
	"Schedule/internal/logic/BaseLogic"
	"Schedule/internal/model/entity"
	"context"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/guid"
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

// Pretreatment
// @Description: 预处理创建路由
// @receiver logic
// @param ctx
// @param routeInfo
// @param param
// @param traceId
func (logic TaskLogic) Pretreatment(ctx context.Context, routeInfo entity.Route, param string, traceId string) PretreatmentResp {

	logic.LoggerInfo(ctx, "Pretreatment:接收数据:"+routeInfo.Name, g.Map{
		"param":      param,
		"trace_id":   traceId,
		"route_info": routeInfo,
	})

	taskDao := logic.GetDao(ctx)

	if traceId == "" {
		traceId = guid.S()
	}

	data := g.Map{
		"main_trace_id": traceId,
		"trace_id":      traceId,
		"param":         param,
		"status":        CONST_TASK_STATUS_0,
		"route_id":      routeInfo.Id,
		"push_url":      routeInfo.PushUrl,
	}

	insertId, err := taskDao.Insert(data)

	if err != nil {
		panic(err.Error())
	}

	logic.LoggerInfo(ctx, "Pretreatment:运行结束:"+routeInfo.Name, g.Map{
		"insert_id":   insertId,
		"insert_data": data,
	})

	return PretreatmentResp{
		TraceId:   traceId,
		RouteName: routeInfo.Name,
		RouteId:   routeInfo.Id,
	}
}
