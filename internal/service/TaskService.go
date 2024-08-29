package service

import (
	"Schedule/internal/consts"
	"Schedule/internal/logic/RouteLogic"
	"Schedule/internal/logic/TaskLogic"
	"context"
	"github.com/gogf/gf/v2/frame/g"
)

type TaskService struct {
	RouteLogic RouteLogic.RouteLogic
	TaskLogic  TaskLogic.TaskLogic
}

func (service TaskService) Pretreatment(ctx context.Context, routeName string, param string) interface{} {
	routeInfo := service.RouteLogic.Find(ctx, g.Map{
		"name": routeName,
	})

	if routeInfo.Id <= 0 {
		panic("Pretreatment异常:路由不存在:route_name:" + routeName)
	}

	traceId := ctx.Value(consts.CtxTraceId).(string)

	return service.TaskLogic.Pretreatment(ctx, routeInfo, param, traceId)
}
