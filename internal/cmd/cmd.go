package cmd

import (
	"Schedule/internal/controller/schedule"
	"Schedule/internal/middleware"
	"context"

	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
	"github.com/gogf/gf/v2/os/gcmd"

	"Schedule/internal/controller/hello"
)

var (
	Main = gcmd.Command{
		Name:  "main",
		Usage: "main",
		Brief: "start http server",
		Func: func(ctx context.Context, parser *gcmd.Parser) (err error) {
			s := g.Server()
			s.Group("/", func(group *ghttp.RouterGroup) {
				group.Middleware(ghttp.MiddlewareHandlerResponse)
				group.Bind(
					hello.NewV1(),
				)
			})

			s.Group("schedule/api", func(group *ghttp.RouterGroup) {
				group.Middleware(middleware.TraceId, middleware.RequestLogger)

				group.ALL("route/create", schedule.Schedule{}.CreateRoute)
				group.ALL("route/edit", schedule.Schedule{}.EditRoute)
				group.ALL("task/pretreatment", schedule.Schedule{}.Pretreatment)
			})

			s.Run()
			return nil
		},
	}
)
