package service

import (
	"Schedule/internal/consts"
	"Schedule/internal/dao"
	"Schedule/internal/logic/RouteLogic"
	"Schedule/internal/logic/TaskLogic"
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

		for key, value := range keyMap {
			_, err := dao.Keymap.Ctx(ctx).Insert(g.Map{
				"key":     key,
				"value":   value,
				"task_id": pretreatmentResp.TaskId,
			})

			if err != nil {
				return err
			}
		}

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

	return g.Map{
		"main":     pretreatmentResp,
		"relation": routeTaskMap,
	}
}

func (service TaskService) Confirm(ctx context.Context, traceId string) interface{} {
	return nil
}
