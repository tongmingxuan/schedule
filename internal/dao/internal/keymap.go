// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// KeymapDao is the data access object for table keymap.
type KeymapDao struct {
	table   string        // table is the underlying table name of the DAO.
	group   string        // group is the database configuration group name of current DAO.
	columns KeymapColumns // columns contains all the column names of Table for convenient usage.
}

// KeymapColumns defines and stores column names for table keymap.
type KeymapColumns struct {
	Id     string //
	Key    string // 字段
	Value  string // 字段value
	TaskId string // 任务ID
}

// keymapColumns holds the columns for table keymap.
var keymapColumns = KeymapColumns{
	Id:     "id",
	Key:    "key",
	Value:  "value",
	TaskId: "task_id",
}

// NewKeymapDao creates and returns a new DAO object for table data access.
func NewKeymapDao() *KeymapDao {
	return &KeymapDao{
		group:   "default",
		table:   "keymap",
		columns: keymapColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *KeymapDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *KeymapDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *KeymapDao) Columns() KeymapColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *KeymapDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *KeymapDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *KeymapDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
