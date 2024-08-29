package middleware

import (
	"Schedule/internal/consts"
	"github.com/gogf/gf/v2/net/ghttp"
	"github.com/gogf/gf/v2/util/guid"
)

// TraceId
// @Description: 设置唯一ID
// @param r
func TraceId(r *ghttp.Request) {

	r.SetCtxVar(consts.CtxTraceId, guid.S())

	r.Middleware.Next()
}
