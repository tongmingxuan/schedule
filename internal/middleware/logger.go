package middleware

import (
	"Schedule/internal/common"
	"Schedule/internal/consts"
	"github.com/gogf/gf/v2/net/ghttp"
)

// RequestLogger
// @Description: 记录请求入参和响应
// @param r
func RequestLogger(r *ghttp.Request) {
	r.Response.CORSDefault()

	request := map[string]interface{}{
		"uri": r.URL.Path,
		"param": map[string]interface{}{
			"get":  r.GetQueryMap(),
			"post": r.GetFormMap(),
		},
	}

	r.Middleware.Next()

	if err := r.GetError(); err != nil {
		common.LoggerError(r.GetCtx(), "request:error", map[string]interface{}{
			"request": request,
			"error":   err.Error(),
		})

		r.Response.WriteStatus(200)

		r.Response.ClearBuffer()

		r.Response.WriteJson(consts.ApiResponse{
			Code:    consts.ErrorApiCode,
			Message: err.Error(),
			TraceId: r.Request.Context().Value(consts.CtxTraceId),
		})

		return
	}

	common.LoggerInfo(r.Context(), "request:success", map[string]interface{}{
		"request":  request,
		"response": r.Response.BufferString(),
	})
}
