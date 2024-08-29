package BaseLogic

import (
	"Schedule/internal/common"
	"context"
	"database/sql"
	"github.com/gogf/gf/v2/database/gdb"
	"github.com/gogf/gf/v2/util/gconv"
)

type Logic interface {
	GetDao(ctx context.Context) *gdb.Model
}

type BaseLogic struct {
}

func (logic BaseLogic) LoggerInfo(ctx context.Context, message string, data interface{}) {
	common.LoggerInfo(ctx, message, data)
}

func (logic BaseLogic) Insert(dao *gdb.Model, insertData interface{}) int {
	id, err := dao.InsertAndGetId(insertData)

	if err != nil {
		panic(err.Error())
	}

	return gconv.Int(id)
}

func (logic BaseLogic) GetListByWhere(dao *gdb.Model, where interface{}, field interface{}) gdb.Result {
	all, err := dao.Fields(field).Where(where).All()

	if err != nil {
		panic(err.Error())
	}

	return all
}

func (logic BaseLogic) FindInfoByWhere(dao *gdb.Model, where interface{}) gdb.Record {
	one, err := dao.Where(where).One()

	if err != nil && err != sql.ErrNoRows {
		panic(err.Error())
	}

	return one
}

func (logic BaseLogic) UpdateByWhere(dao *gdb.Model, where interface{}, update interface{}) int {
	result, err := dao.Data(update).Where(where).Update()

	if err != nil {
		panic(err.Error())
	}

	row, rowErr := result.RowsAffected()

	if rowErr != nil {
		panic(rowErr.Error())
	}

	return gconv.Int(row)
}
