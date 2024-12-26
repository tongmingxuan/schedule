package main

import (
	"Schedule/internal/cmd"
	_ "Schedule/internal/packed"
	_ "github.com/gogf/gf/contrib/drivers/mysql/v2"
	_ "github.com/gogf/gf/contrib/nosql/redis/v2"
	"github.com/gogf/gf/v2/os/gctx"
	"log"
	"net/http"
	_ "net/http/pprof"
)

func main() {
	//http://localhost:6060/debug/pprof/
	go func() {
		log.Println(http.ListenAndServe("localhost:6060", nil))
	}()

	cmd.Main.Run(gctx.GetInitCtx())
}
