package request

import "github.com/gogf/gf/v2/frame/g"

type PretreatmentReq struct {
	RouteName   string `p:"route_name"  v:"required#请输入路由名称:route_name"`
	Param       g.Map  `p:"param"  v:"required#请输入投递及参数:param"`
	MainTraceId string `p:"main_trace_id"`
	KeyMap      g.Map  `p:"key_map"`
}

type ConfirmReq struct {
	TraceId string `p:"trace_id"  v:"required#请输入跟踪ID:trace_id"`
}

type FinishReq struct {
	TraceId string `p:"trace_id"  v:"required#请输入跟踪ID:trace_id"`
	Param   g.Map  `p:"param"  `
	KeyMap  g.Map  `p:"key_map"`
}

type TestReq struct {
	TraceId     string `p:"trace_id"  v:"required#请输入跟踪ID:trace_id"`
	MainTraceId string `p:"main_trace_id"  v:"required#请输入跟踪ID:trace_id"`
	Param       g.Map  `p:"param"  `
	KeyMap      g.Map  `p:"key_map"`
}
