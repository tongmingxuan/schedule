package TaskLogic

// PretreatmentResp
// @Description: 预处理响应结构
type PretreatmentResp struct {
	TraceId   string `json:"trace_id"`
	RouteName string `json:"route_name"`
	RouteId   int    `json:"route_id"`
	TaskId    int    `json:"task_id"`
}
