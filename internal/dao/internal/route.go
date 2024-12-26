// ==========================================================================
// Code generated and maintained by GoFrame CLI tool. DO NOT EDIT.
// ==========================================================================

package internal

import (
	"context"

	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/frame/g"
)

// RouteDao is the data access object for table route.
type RouteDao struct {
	table   string       // table is the underlying table name of the DAO.
	group   string       // group is the database configuration group name of current DAO.
	columns RouteColumns // columns contains all the column names of Table for convenient usage.
}

// RouteColumns defines and stores column names for table route.
type RouteColumns struct {
	Id          string //
	MainId      string // 主路由ID
	Name        string // 路由名称
	Config      string // 配置参数
	PushUrl     string // push地址
	ParentId    string // 上级ID
	Concurrency string // 并发数量
	Delay       string // 延迟多少秒运行
	Sleep       string // 运行一轮休息时间
	Limit       string // 一轮获取多少数据
	CreatedAt   string //
	UpdatedAt   string //
	DeletedAt   string //
}

// routeColumns holds the columns for table route.
var routeColumns = RouteColumns{
	Id:          "id",
	MainId:      "main_id",
	Name:        "name",
	Config:      "config",
	PushUrl:     "push_url",
	ParentId:    "parent_id",
	Concurrency: "concurrency",
	Delay:       "delay",
	Sleep:       "sleep",
	Limit:       "limit",
	CreatedAt:   "created_at",
	UpdatedAt:   "updated_at",
	DeletedAt:   "deleted_at",
}

// NewRouteDao creates and returns a new DAO object for table data access.
func NewRouteDao() *RouteDao {
	return &RouteDao{
		group:   "default",
		table:   "route",
		columns: routeColumns,
	}
}

// DB retrieves and returns the underlying raw database management object of current DAO.
func (dao *RouteDao) DB() gdb.DB {
	return g.DB(dao.group)
}

// Table returns the table name of current dao.
func (dao *RouteDao) Table() string {
	return dao.table
}

// Columns returns all column names of current dao.
func (dao *RouteDao) Columns() RouteColumns {
	return dao.columns
}

// Group returns the configuration group name of database of current dao.
func (dao *RouteDao) Group() string {
	return dao.group
}

// Ctx creates and returns the Model for current DAO, It automatically sets the context for current operation.
func (dao *RouteDao) Ctx(ctx context.Context) *gdb.Model {
	return dao.DB().Model(dao.table).Safe().Ctx(ctx)
}

// Transaction wraps the transaction logic using function f.
// It rollbacks the transaction and returns the error from function f if it returns non-nil error.
// It commits the transaction and returns nil if function f returns nil.
//
// Note that, you should not Commit or Rollback the transaction in function f
// as it is automatically handled by this function.
func (dao *RouteDao) Transaction(ctx context.Context, f func(ctx context.Context, tx gdb.TX) error) (err error) {
	return dao.Ctx(ctx).Transaction(ctx, f)
}
