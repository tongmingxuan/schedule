package request

type RouteCreateReq struct {
	Name string `p:"name"  v:"required#请输入路由名称:name"`
	// 推送队列接口地址
	PushUrl string `p:"push_url"  v:"required|url#请输入推送http地址:push_url"`
	// 并发数量
	Concurrency int `p:"concurrency" default:"1"`
	// 延时多长时间
	Delay int `p:"delay"  default:"0"`
	// 上级路由
	ParentId int `p:"parent_id" default:"0"`
	// 主路由
	MainId int `p:"main_id" default:"0"`
	// 一轮获取多少数据
	Limit int `p:"limit" default:"10"`
	// 一轮休息多少秒
	Sleep int `p:"sleep" default:"10"`
}

type RouteEditReq struct {
	Id int `p:"id"  v:"required#请输入路由id:id"`
	RouteCreateReq
}
