package service

import (
	"Schedule/internal/common"
	"Schedule/internal/consts"
	"Schedule/internal/logic/RouteLogic"
	"Schedule/internal/logic/TaskLogic"
	"Schedule/internal/model/entity"
	"context"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/guid"
)

type TaskService struct {
	RouteLogic RouteLogic.RouteLogic
	TaskLogic  TaskLogic.TaskLogic
}

// Pretreatment
// @Description: 预处理
// @receiver service
// @param ctx
// @param routeName 路由名称
// @param param 投递参数
// @param keyMap 查询参数
// @return interface{}
func (service TaskService) Pretreatment(ctx context.Context, routeName string, param interface{}, keyMap g.Map) interface{} {
	common.LoggerInfo(ctx, "pretreatment:接收导数据:"+routeName, g.Map{
		"route_name": routeName,
		"param":      param,
		"key_map":    keyMap,
	})

	routeInfo := service.RouteLogic.Find(ctx, g.Map{
		"name": routeName,
	})

	if routeInfo.Id <= 0 {
		panic("Pretreatment异常:路由不存在:route_name:" + routeName)
	}

	if routeInfo.ParentId != 0 {
		panic("Pretreatment异常:不是主路由:route_name:" + routeName)
	}

	routeList := service.RouteLogic.GetList(ctx, g.Map{"main_id": routeInfo.Id}, g.Slice{
		"id", "name", "push_url", "parent_id", "delay",
	})

	traceId := ctx.Value(consts.CtxTraceId).(string)

	var pretreatmentResp TaskLogic.PretreatmentResp

	routeTaskMap := make(map[int]int)

	err := g.DB().Transaction(ctx, func(ctx context.Context, tx gdb.TX) error {
		//主任务
		pretreatmentResp = service.TaskLogic.CreateTask(ctx, routeInfo, param, traceId, traceId)

		service.TaskLogic.CreateKeyMap(ctx, keyMap, pretreatmentResp.TaskId)

		routeTaskMap[routeInfo.Id] = pretreatmentResp.TaskId

		for _, route := range routeList {
			if route.Id == routeInfo.Id {
				continue
			}

			parentTaskId, exists := routeTaskMap[route.ParentId]

			if !exists {
				panic("路由配置关系异常")
			}

			child := service.TaskLogic.CreateTask(ctx, route, nil, guid.S(), traceId)

			service.TaskLogic.Update(ctx, g.Map{"id": child.TaskId}, g.Map{"parent_id": parentTaskId})

			routeTaskMap[route.Id] = child.TaskId
		}

		return nil
	})

	if err != nil {
		panic(err.Error())
	}

	common.LoggerInfo(ctx, "pretreatment:任务创建成功:"+routeName, g.Map{
		"main":     pretreatmentResp,
		"relation": routeTaskMap,
	})

	return g.Map{
		"main":     pretreatmentResp,
		"relation": routeTaskMap,
	}
}

// Confirm
// @Description: 确认并投递
// @receiver service
// @param ctx
// @param traceId
// @return interface{}
func (service TaskService) Confirm(ctx context.Context, traceId string) interface{} {
	common.LoggerInfo(ctx, "confirm接收导数据", g.Map{
		"trace_id": traceId,
	})

	taskLogic := service.TaskLogic

	taskInfo := taskLogic.Find(ctx, g.Map{"trace_id": traceId})

	if taskInfo.Id == 0 {
		panic("任务不存在:trace_id:" + traceId)
	}

	if taskInfo.Status != TaskLogic.ConstWaitingRun {
		panic("任务状态不为待运行:trace_id:" + traceId)
	}

	if taskInfo.MainTraceId != taskInfo.TraceId {
		panic("当前任务不为主任务:trace_id:" + traceId)
	}

	taskLogic.ToFinishSortedSet(ctx, taskInfo, nil)

	common.LoggerInfo(ctx, "confirm投递finish集合成功", g.Map{
		"trace_id": traceId,
	})

	return taskInfo
}

func (service TaskService) Finish(ctx context.Context, traceId string, keyMap, param g.Map) interface{} {
	common.LoggerInfo(ctx, "Finish:接收到数据", g.Map{"trace_id": traceId, "param": param, "keyMap": keyMap})

	return service.TaskLogic.Finish(ctx, traceId, keyMap, param)
}

func (service TaskService) FindInfo(ctx context.Context, traceId string) entity.Task {
	return service.TaskLogic.Find(ctx, g.Map{"trace_id": traceId})
}
