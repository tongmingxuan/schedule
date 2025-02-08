package Process

import (
	"Schedule/internal/common"
	"Schedule/internal/logic/RedisLogic"
	"Schedule/internal/logic/RouteLogic"
	"Schedule/internal/logic/TaskLogic"
	"Schedule/internal/model/entity"
	"context"
	"github.com/gogf/gf/v2/database/gredis"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gctx"
	"github.com/gogf/gf/v2/os/gtimer"
	"github.com/gogf/gf/v2/util/gconv"
	"github.com/gogf/gf/v2/util/guid"
	"time"
)

// Listen
// @Description: 监听channel创建finish消费协程
func Listen() {
	content := gctx.New()

	listenUuid := guid.S()

	common.LoggerSystem(content, "Listen:开始运行", g.Map{"listen_uuid": listenUuid})

	runNumber := 0

	defer func() {
		if r := recover(); r != nil {
			common.LoggerSystem(content, "运行发生异常", g.Map{
				"r":           r,
				"listen_uuid": listenUuid,
			})

			Listen()
		}
	}()

	for true {
		select {
		case routeChannelResult := <-common.FinishMonitorChannel:

			runNumber++

			data := g.Map{
				"run_number":           runNumber,
				"route_channel_result": routeChannelResult,
				"channel_len":          len(common.FinishMonitorChannel),
				"listen_uuid":          listenUuid,
			}

			//g.Dump("select:channel:接收到数据:", data)
			common.LoggerSystem(content, "select:channel:接收到数据:", data)

			FinishWorkerMonitor(routeChannelResult, listenUuid)
		}
	}
}

// FinishWorkerMonitor
// @Description: 创建队列消费
// @param routeId
// @param listenUuid
func FinishWorkerMonitor(routeId int, listenUuid string) {
	ctx := gctx.New()

	defer func() {
		if r := recover(); r != nil {
			common.LoggerSystem(ctx, "运行发生异常", g.Map{
				"r":           r,
				"listen_uuid": listenUuid,
				"route_id":    routeId,
			})
		}
	}()

	redis := RedisLogic.Redis{}

	aliveKey := common.FinishCustomerAliveQueue + gconv.String(routeId)

	common.LoggerSystem(ctx, "FinishWorkerMonitor:接收到数据", g.Map{
		"route_id":    routeId,
		"listen_uuid": listenUuid,
		"alive_key":   aliveKey,
	})

	alive := redis.Get(aliveKey)

	if alive.String() != "" {
		common.LoggerSystem(ctx, "FinishWorkerMonitor:队列存活中:不创建消费者", g.Map{
			"route_id": routeId,
		})

		return
	}

	routeInfo := RouteLogic.RouteLogic{}.Find(ctx, g.Map{"id": routeId})

	if routeInfo.Id == 0 {
		common.LoggerSystem(ctx, "FinishWorkerMonitor:队列不存在:不创建消费者", g.Map{
			"route_id": routeId,
		})

		return
	}

	go WorkerHandle(routeInfo, aliveKey)

	common.LoggerSystem(ctx, "FinishWorkerMonitor:创建路由消费队列成功:创建消费者", g.Map{
		"route_id": routeId,
	})
}

// WorkerHandle
// @Description: 路由消费队列
// @param routeInfo
// @param aliveKey
func WorkerHandle(routeInfo entity.Route, aliveKey string) {
	ctx := gctx.New()

	queueUuid := guid.S()

	defer func() {
		if r := recover(); r != nil {
			common.LoggerSystem(ctx, "WorkerHandle:route_name:"+routeInfo.Name+":运行出现异常", g.Map{
				"queue_uuid": queueUuid,
				"error":      r,
			})
		}
	}()

	common.LoggerSystem(ctx, "WorkerHandle:route_name:"+routeInfo.Name+":队列启动", g.Map{
		"route_info": routeInfo,
		"alive":      aliveKey,
		"queue_uuid": queueUuid,
	})

	redis := RedisLogic.Redis{}

	var number int = 0

	/*上报当前消费者心跳*/
	gTimerEntry := gtimer.AddSingleton(ctx, 5*time.Second, func(ctx context.Context) {
		defer func() {
			if r := recover(); r != nil {
				common.LoggerSystem(ctx, "WorkerHandle:定时器上报异常:route_name:"+routeInfo.Name+":运行出现异常", g.Map{
					"queue_uuid": queueUuid,
					"error":      r,
				})
			}
		}()

		dateTime := time.Now().Format("2006-01-02 15:04:05")

		redis.Set(aliveKey, dateTime, gredis.SetOption{
			TTLOption: gredis.TTLOption{
				EX: gconv.PtrInt64(60),
			},
		})
	})

	/*删除定时器,删除存活状态*/
	defer func() {
		common.LoggerSystem(ctx, "WorkerHandle:route_name:"+routeInfo.Name+":队列运行结束", g.Map{
			"queue_uuid": queueUuid,
		})
		gTimerEntry.Close()
		redis.Delete(aliveKey)
	}()

	for true {
		number++

		if number >= 200 {
			break
		}

		Process(ctx, routeInfo, number)
	}
}

// Process
// @Description: 队列消费
// @param routeInfo
func Process(ctx context.Context, routeInfo entity.Route, number int) {
	defer func() {
		if r := recover(); r != nil {
			common.LoggerInfo(ctx, "Process:route_name:"+routeInfo.Name+":运行出现异常:exit-process", g.Map{
				"error": r,
			})
		}
	}()

	redis := RedisLogic.InitRedis(ctx)

	sortedSetName := TaskLogic.TaskLogic{}.FinishSetName(routeInfo.Id)

	common.LoggerSystem(ctx, routeInfo.Name+":finish:Process开始运行", g.Map{
		"number":     number,
		"sorted_set": sortedSetName,
	})

	count := 200

	for true {
		count--

		if count <= 0 {
			break
		}

		//判断如果子任务集合任务数量超过 路由limit * 2的数量 则不消费

		// 从集合中获取数据
		list := redis.GetSortedSetItem(sortedSetName, time.Now().Unix(), routeInfo.Limit)

		if len(list) == 0 {
			time.Sleep(5 * time.Second)

			continue
		}

		for _, traceId := range list {
			go func(ctx context.Context, traceId string, routeInfo entity.Route) {
				defer func() {
					if r := recover(); r != nil {
						common.LoggerSystem(ctx, "trace_id:"+traceId+":调用finish-api异常", g.Map{
							"error": r,
						})
					}
				}()

				redisLogic := RedisLogic.InitRedis(ctx)

				lockName := "call-finish-lock-" + traceId

				lockValue := guid.S()

				defer func() {
					redisLogic.ReleaseLock(lockName, lockValue)
				}()

				redisLogic.Lock(lockName, lockValue, 5, 15)

				TaskLogic.TaskLogic{}.CallFinishApi(ctx, traceId, routeInfo)
			}(ctx, traceId, routeInfo)
		}

		sleep := time.Duration(routeInfo.Sleep) * time.Second

		time.Sleep(sleep)
	}
}
