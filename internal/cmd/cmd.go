package cmd

import (
	"Schedule/internal/controller/hello"
	"Schedule/internal/controller/schedule"
	"Schedule/internal/middleware"
	"Schedule/internal/service/Process"
	"Schedule/internal/service/Timer"
	"context"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/ghttp"
	"github.com/gogf/gf/v2/os/gcmd"
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
				group.ALL("task/test", schedule.Schedule{}.Test)

				group.ALL("route/create", schedule.Schedule{}.CreateRoute)
				group.ALL("route/edit", schedule.Schedule{}.EditRoute)
				group.ALL("task/pretreatment", schedule.Schedule{}.Pretreatment)
				group.ALL("task/confirm", schedule.Schedule{}.Confirm)
				group.ALL("task/finish", schedule.Schedule{}.Finish)
				group.ALL("task/find", schedule.Schedule{}.FindInfo)
			})

			go func() {
				Process.Listen()
			}()

			Timer.Init(ctx)

			s.Run()
			return nil
		},
	}
)
