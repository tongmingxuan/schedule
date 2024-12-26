// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// Route is the golang structure of table route for DAO operations like Where/Data.
type Route struct {
	g.Meta      `orm:"table:route, do:true"`
	Id          interface{} //
	MainId      interface{} // 主路由ID
	Name        interface{} // 路由名称
	Config      interface{} // 配置参数
	PushUrl     interface{} // push地址
	ParentId    interface{} // 上级ID
	Concurrency interface{} // 并发数量
	Delay       interface{} // 延迟多少秒运行
	Sleep       interface{} // 运行一轮休息时间
	Limit       interface{} // 一轮获取多少数据
	CreatedAt   *gtime.Time //
	UpdatedAt   *gtime.Time //
	DeletedAt   *gtime.Time //
}
