// =================================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// =================================================================================

package entity

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// Keymap is the golang structure for table keymap.
type Keymap struct {
	Id        uint64      `json:"id"         ` //
	Key       string      `json:"key"        ` // 字段
	Value     string      `json:"value"      ` // 字段value
	TaskId    int64       `json:"task_id"    ` // 任务ID
	CreatedAt *gtime.Time `json:"created_at" ` //
}
