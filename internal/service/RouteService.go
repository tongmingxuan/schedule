package service

import (
	"Schedule/internal/logic/RouteLogic"
	"Schedule/internal/model/entity"
	"Schedule/internal/request"
	"context"
	"errors"
	"github.com/gogf/gf/v2/database/gdb"
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

	if createRequest.ParentId > 0 {
		parentRoute := logic.Find(ctx, map[string]int{
			"id": createRequest.ParentId,
		})

		if parentRoute.Id == 0 {
			panic("主路由不存在:" + gconv.String(parentRoute.Id))
		}

		createRequest.MainId = parentRoute.MainId
	}

	ctx = context.WithValue(ctx, "createInfo", createRequest)

	var insertId int

	err := g.DB().Transaction(ctx, func(ctx context.Context, tx gdb.TX) error {

		createInfo, success := ctx.Value("createInfo").(request.RouteCreateReq)

		insertId = logic.Create(ctx, createInfo)

		if createInfo.ParentId == 0 {
			logic.Update(ctx, g.Map{"id": insertId}, g.Map{"main_id": insertId})
		}

		if !success {
			return errors.New("断言失败")
		}

		return nil
	})

	if err != nil {
		panic(err.Error())
	}

	return logic.Find(ctx, g.Map{"id": insertId})
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
