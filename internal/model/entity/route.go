// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// Route is the golang structure for table route.
type Route struct {
	Id          int         `json:"id"          ` //
	Name        string      `json:"name"        ` // 路由名称
	Config      string      `json:"config"      ` // 配置参数
	PushUrl     string      `json:"push_url"    ` // push地址
	NextId      int         `json:"next_id"     ` // finish后下级路由
	Concurrency int         `json:"concurrency" ` // 并发数量
	Delay       int         `json:"delay"       ` // 延迟多少秒运行
	CreatedAt   *gtime.Time `json:"created_at"  ` //
	UpdatedAt   *gtime.Time `json:"updated_at"  ` //
	DeletedAt   *gtime.Time `json:"deleted_at"  ` //
}
