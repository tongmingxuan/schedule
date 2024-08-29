package RouteLogic

import (
	"Schedule/internal/dao"
	"Schedule/internal/logic/BaseLogic"
	"Schedule/internal/model/entity"
	"context"
	"github.com/gogf/gf/v2/database/gdb"
)

type RouteLogic struct {
	BaseLogic.BaseLogic
}

func (logic RouteLogic) GetDao(ctx context.Context) *gdb.Model {
	return dao.Route.Ctx(ctx)
}

func (logic RouteLogic) Create(ctx context.Context, data interface{}) int {
	insertId := logic.Insert(logic.GetDao(ctx), data)

	if insertId <= 0 {
		panic("插入路由异常")
	}

	return insertId
}

// Find
// @Description: 查询单条路由配置
// @receiver logic
// @param ctx
// @param where
// @return entity.Route
func (logic RouteLogic) Find(ctx context.Context, where interface{}) entity.Route {
	var routeInfo entity.Route

	result := logic.FindInfoByWhere(logic.GetDao(ctx), where)

	if len(result.Map()) == 0 {
		return routeInfo
	}

	err := result.Struct(&routeInfo)

	if err != nil {
		return entity.Route{}
	}

	return routeInfo
}

func (logic RouteLogic) Update(ctx context.Context, where interface{}, update interface{}) int {
	return logic.UpdateByWhere(logic.GetDao(ctx), where, update)
}
