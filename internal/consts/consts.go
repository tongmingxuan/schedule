package consts

// CtxTraceId  上下文设置 运行追踪ID
const CtxTraceId = "trace_id"

// ApiResponse 接口响应格式
type ApiResponse struct {
	Code    int         `json:"code"`
	Message string      `json:"message"`
	Data    interface{} `json:"data"`
	TraceId interface{} `json:"trace_id"`
}

// ErrorApiCode api异常code
const ErrorApiCode = 500

// ConfirmSetName confirm集合名称
const ConfirmSetName = "confirm:confirm_set_"

// FinishSetName finish集合名称
const FinishSetName = "finish:finish_set_"
