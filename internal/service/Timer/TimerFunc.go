package Timer

import (
	"context"
	"github.com/gogf/gf/v2/os/gtimer"
	"time"
)

func Init(ctx context.Context) {
	gtimer.AddSingleton(ctx, 30*time.Second, RouteMonitor)
}
