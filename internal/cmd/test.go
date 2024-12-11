package cmd

import (
	"Schedule/internal/logic/RedisLogic"
	"context"
	"github.com/gogf/gf/v2/os/gcmd"
)

var (
	Test = gcmd.Command{
		Name:  "main",
		Usage: "main",
		Brief: "start http server",
		Func: func(ctx context.Context, parser *gcmd.Parser) (err error) {

			redis := RedisLogic.Redis{}

			redis.Lock("xxx", "xxx", 10, 50)

			redis.ReleaseLock("xxx", "xxx")

			return nil
		},
	}
)
