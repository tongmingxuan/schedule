package RedisLogic

import (
	"context"
	"github.com/gogf/gf/v2/container/gvar"
	"github.com/gogf/gf/v2/database/gredis"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/util/gconv"
	"time"
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

func (r Redis) Get(key string, connection ...string) *gvar.Var {
	get, err := r.RedisClient(connection...).Get(r.ctx, key)

	if err != nil {
		panic(err.Error())
	}

	return get
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

// Lock
// @Description: 获取redis锁
// @receiver r
// @param lockName 锁名称
// @param lockValue 锁value
// @param getLockTime 获取锁时间
// @param ttl 锁过期时间
// @param connection 链接名称
func (r Redis) Lock(lockName string, lockValue string, getLockTime int, ttl int, connection ...string) bool {
	startTime := time.Now()

	for true {
		nowTime := time.Now()

		if int(nowTime.Sub(startTime).Seconds()) >= getLockTime {
			panic("获取锁超时:" + lockName)
		}

		set, err := r.RedisClient(connection...).Set(r.ctx, lockName, lockValue, gredis.SetOption{
			NX: true,
			TTLOption: gredis.TTLOption{
				EX: gconv.PtrInt64(ttl),
			},
		})

		if set.String() == "OK" {
			break
		}

		if err != nil {
			panic("获取锁异常:" + lockName + ":" + err.Error())
		}

		time.Sleep(500 * time.Millisecond)

		continue
	}

	return true
}

// ReleaseLock
// @Description: 删除锁
// @receiver r
// @param lockName
// @param lockValue
// @param connection
// @return int
func (r Redis) ReleaseLock(lockName string, lockValue string, connection ...string) int {
	res := r.Get(lockName)

	if lockValue == res.String() {
		del, err := r.RedisClient(connection...).Del(r.ctx, lockName)

		if err != nil {
			panic("删除锁异常:" + lockName)
		}

		return int(del)
	}

	return 0
}
