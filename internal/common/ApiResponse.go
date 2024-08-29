package common

import (
	"Schedule/internal/consts"
	"github.com/gogf/gf/v2/net/ghttp"
)

func ApiResponse(req *ghttp.Request, data interface{}) {
	if data == nil {
		data = make(map[string]interface{})
	}

	req.Response.WriteJson(consts.ApiResponse{
		Code:    200,
		Message: "success",
		Data:    data,
		TraceId: req.Request.Context().Value(consts.CtxTraceId),
	})
}
