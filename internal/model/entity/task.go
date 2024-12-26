// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// Task is the golang structure for table task.
type Task struct {
	Id          int         `json:"id"            ` // 运行次数
	ParentId    int         `json:"parent_id"     ` // 上级任务ID
	MainTraceId string      `json:"main_trace_id" ` // 主-跟踪ID
	TraceId     string      `json:"trace_id"      ` // 跟踪ID
	RouteId     int         `json:"route_id"      ` // 路由ID
	PushUrl     string      `json:"push_url"      ` // 推送地址
	Param       string      `json:"param"         ` // 初始参数
	Result      string      `json:"result"        ` // 运行结果
	Status      int         `json:"status"        ` // 运行状态  0待调度 1已投递 2已接收finish 3子任务生成成功  4运行成功  5运行异常  6作废
	Count       int         `json:"count"         ` // 运行次数
	Delay       int         `json:"delay"         ` // 延时运行
	CreatedAt   *gtime.Time `json:"created_at"    ` //
	UpdatedAt   *gtime.Time `json:"updated_at"    ` //
	DeletedAt   *gtime.Time `json:"deleted_at"    ` //
}
