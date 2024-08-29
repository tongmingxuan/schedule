package service

import (
	"Schedule/internal/logic/RouteLogic"
	"Schedule/internal/model/entity"
	"Schedule/internal/request"
	"context"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/gconv"
)

type RouteService struct {
	Logic RouteLogic.RouteLogic
}

func (service RouteService) CreateRoute(ctx context.Context, createRequest request.RouteCreateReq) entity.Route {
	logic := service.Logic

	var routeInfo entity.Route = logic.Find(ctx, map[string]string{
		"name": createRequest.Name,
	})

	if routeInfo.Id > 0 {
		panic("路由已存在:route_id:" + gconv.String(routeInfo.Id))
	}

	return logic.Find(ctx, map[string]int{
		"id": logic.Create(ctx, createRequest),
	})
}

func (service RouteService) EditRoute(ctx context.Context, createRequest request.RouteEditReq) int {
	logic := service.Logic

	routeInfo := logic.Find(ctx, g.Map{"id": createRequest.Id})

	if routeInfo.Id <= 0 {
		panic("路由不存在:route_id:" + gconv.String(routeInfo.Id))
	}

	row := logic.Update(ctx, map[string]interface{}{
		"id": createRequest.Id,
	}, createRequest)

	return row
}
