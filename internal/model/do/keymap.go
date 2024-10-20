// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package do

import (
	"github.com/gogf/gf/v2/frame/g"
)

// Keymap is the golang structure of table keymap for DAO operations like Where/Data.
type Keymap struct {
	g.Meta `orm:"table:keymap, do:true"`
	Id     interface{} //
	Key    interface{} // 字段
	Value  interface{} // 字段value
	TaskId interface{} // 任务ID
}
