package RedisLogic

import (
	"context"
	"github.com/gogf/gf/v2/container/gvar"
	"github.com/gogf/gf/v2/database/gredis"
	"github.com/gogf/gf/v2/frame/g"
)

func InitRedis(ctx context.Context) Redis {
	return Redis{ctx: ctx}
}

type Redis struct {
	ctx context.Context
}

// RedisClient
// @Description: 获取redis链接
// @receiver r
// @param connection 连接池名称 默认为default
// @return *gredis.Redis
func (r Redis) RedisClient(connection ...string) *gredis.Redis {
	if len(connection) > 0 {
		return g.Redis(connection[0])
	} else {
		return g.Redis("default")
	}
}

func (r Redis) Set(key string, value string, connection ...string) *gvar.Var {
	set, err := r.RedisClient(connection...).Set(r.ctx, key, value)

	if err != nil {
		panic(err.Error())
	}

	return set
}

// AddSortedSet
// @Description: 设置有序集合
// @receiver r
// @param sortedSetKey 集合名称
// @param score 分数
// @param member 元素
// @param connection 连接
// @return *gvar.Var
func (r Redis) AddSortedSet(sortedSetKey string, score int64, member string, connection ...string) *gvar.Var {

	option := gredis.ZAddOption{}

	add, err := r.RedisClient(connection...).ZAdd(r.ctx, sortedSetKey, &option, gredis.ZAddMember{
		Score:  float64(score),
		Member: member,
	})

	if err != nil {
		panic(err.Error())
	}

	return add
}
