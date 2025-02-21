// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// Task is the golang structure of table task for DAO operations like Where/Data.
type Task struct {
	g.Meta       `orm:"table:task, do:true"`
	Id           interface{} // 运行次数
	ParentId     interface{} // 上级任务ID
	MainTraceId  interface{} // 主-跟踪ID
	TraceId      interface{} // 跟踪ID
	RouteId      interface{} // 路由ID
	PushUrl      interface{} // 推送地址
	Param        interface{} // 初始参数
	RequestParam interface{} // 调用Finish-api传递参数
	Result       interface{} // 运行结果
	Status       interface{} // 运行状态  0待调度 1已投递 2已接收finish 3子任务生成成功  4运行成功  5运行异常  6作废
	Count        interface{} // 运行次数
	Delay        interface{} // 延时运行
	CreatedAt    *gtime.Time //
	UpdatedAt    *gtime.Time //
	DeletedAt    *gtime.Time //
}
