package common

import (
	"Schedule/internal/consts"
	"context"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

func LoggerInfo(ctx context.Context, message string, data interface{}) {
	g.Log("info").Info(ctx, g.Map{
		"a-message":       message,
		"data":            data,
		"datetime":        gtime.Datetime(),
		consts.CtxTraceId: ctx.Value(consts.CtxTraceId),
	})
}

func LoggerError(ctx context.Context, message string, data map[string]interface{}) {
	g.Log("error").Error(ctx, g.Map{
		"a-message":       message,
		"data":            data,
		"time":            gtime.Datetime(),
		"stack":           g.Log("info").GetStack(),
		consts.CtxTraceId: ctx.Value(consts.CtxTraceId),
	})
}

func LoggerSystem(ctx context.Context, message string, data map[string]interface{}) {
	g.Log("system").Info(ctx, g.Map{
		"a-message": message,
		"data":      data,
		"time":      gtime.Datetime(),
	})
}

func Stack() string {
	return g.Log("info").GetStack()
}
