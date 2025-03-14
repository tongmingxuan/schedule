package service

import (
	"Schedule/internal/common"
	"Schedule/internal/consts"
	"Schedule/internal/logic/RedisLogic"
	"Schedule/internal/logic/RouteLogic"
	"Schedule/internal/logic/TaskLogic"
	"Schedule/internal/model/entity"
	"context"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/guid"
	"time"
)

type TaskService struct {
	RouteLogic RouteLogic.RouteLogic
	TaskLogic  TaskLogic.TaskLogic
	RedisLogic RedisLogic.Redis
}

// Pretreatment
// @Description: 预处理
// @receiver service
// @param ctx
// @param routeName 路由名称
// @param param 投递参数
// @param keyMap 查询参数
// @return interface{}
func (service TaskService) Pretreatment(ctx context.Context, routeName string, param interface{}, keyMap g.Map, delay int) interface{} {
	common.LoggerInfo(ctx, "pretreatment:接收导数据:"+routeName, g.Map{
		"route_name": routeName,
		"param":      param,
		"key_map":    keyMap,
		"delay":      delay,
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
		pretreatmentResp = service.TaskLogic.CreateTask(ctx, routeInfo, param, traceId, traceId, delay)

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

			child := service.TaskLogic.CreateTask(ctx, route, nil, guid.S(), traceId, 0)

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
	common.LoggerInfo(ctx, "confirm接收到数据", g.Map{
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
	redis := RedisLogic.InitRedis(ctx)

	lockValue := guid.S()

	redis.Lock(traceId, lockValue, 5, 15)

	defer func() {
		redis.ReleaseLock(traceId, lockValue)
	}()

	return service.TaskLogic.Find(ctx, g.Map{"trace_id": traceId})
}

// Retry
// @Description: 修改任务状态重新投递
// @receiver service
// @param ctx
// @param traceId
func (service TaskService) Retry(ctx context.Context, traceId string) g.Map {
	common.LoggerInfo(ctx, "Retry:接收到数据", g.Map{"trace_id": traceId})

	redis := RedisLogic.InitRedis(ctx)

	lockValue := guid.S()

	redis.Lock(traceId, lockValue, 5, 15)

	defer func() {
		redis.ReleaseLock(traceId, lockValue)
	}()

	task := service.TaskLogic.Find(ctx, g.Map{"trace_id": traceId})

	if task.Id == 0 {
		panic("Retry:任务不存在:trace_id:" + traceId)
	}

	if task.ParentId == 0 {
		_, err := service.TaskLogic.GetDao(ctx).
			WhereNotIn("status", []int{
				TaskLogic.ConstRunSuccess,
				TaskLogic.ConstFinishSuccess,
				TaskLogic.ConstCancel,
			}).Where(g.Map{"main_trace_id": task.MainTraceId}).
			Data(g.Map{"status": TaskLogic.ConstAlreadyPushFinish, "count": 0}).Update()

		if err != nil {
			panic("Retry:主任务重试运行异常:trace_id:" + traceId)
		}
	} else {
		service.TaskLogic.Update(ctx, g.Map{"trace_id": task.TraceId}, g.Map{"status": TaskLogic.ConstAlreadyPushFinish, "count": 0})
	}

	service.TaskLogic.AddFinishSortedSet(ctx, task.RouteId, time.Now().Unix(), traceId)

	return g.Map{"trace_id": traceId}
}
