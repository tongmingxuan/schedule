package Timer

import (
	"Schedule/internal/common"
	"Schedule/internal/service"
	"context"
	"fmt"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/glog"
)

// RouteMonitor
// @Description: 根据路由配置定时投递channel监听集合
// @param ctx
func RouteMonitor(ctx context.Context) {
	glog.Print(ctx, "RouteMonitor:running")

	defer func() {
		if err := recover(); err != nil {
			common.LoggerSystem(ctx, "RouteMonitor:error", g.Map{
				"err": err,
			})
		}
	}()

	routeList := service.RouteService{}.Logic.GetList(ctx, nil, []string{"id", "name"})

	glog.Print(ctx, routeList)

	for _, route := range routeList {
		common.FinishMonitorChannel <- route.Id
		fmt.Println(len(common.FinishMonitorChannel))
	}

}
