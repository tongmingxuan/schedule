package request

type PretreatmentReq struct {
	RouteName   string `p:"route_name"  v:"required#请输入路由名称:route_name"`
	Param       string `p:"param"  v:"required#请输入投递及参数:param"`
	MainTraceId string `p:"main_trace_id"`
}

type ConfirmReq struct {
	TraceId string `p:"trace_id"  v:"required#请输入跟踪ID:trace_id"`
}
