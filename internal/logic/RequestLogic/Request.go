package RequestLogic

import (
	"Schedule/internal/common"
	"context"
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/net/gclient"
)

type Request struct {
}

func (request Request) Client() *gclient.Client {
	return g.Client()
}

func (request Request) Post(ctx context.Context, url string, param g.Map) string {
	common.LoggerInfo(ctx, "post:接收到参数", g.Map{
		"url":   url,
		"param": param,
	})

	post, err := request.Client().Post(ctx, url, param)

	defer func() {
		_ = post.Close()
	}()

	if err != nil {
		common.LoggerInfo(ctx, "post:存在异常:error", g.Map{
			"err": err.Error(),
		})

		panic("error:" + err.Error())
	}

	response := post.ReadAllString()

	common.LoggerInfo(ctx, "post:获取响应", g.Map{
		"response": response,
	})

	return response
}
