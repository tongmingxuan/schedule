package schedule

import (
	"Schedule/internal/common"
	"Schedule/internal/consts"
	"Schedule/internal/request"
	"Schedule/internal/service"
	"github.com/gogf/gf/v2/net/ghttp"
)

type Schedule struct {
}

// CreateRoute
// @Description: 路由创建
// @receiver controller
// @param req
func (controller Schedule) CreateRoute(req *ghttp.Request) {

	createRouteRequest := request.RouteCreateReq{}

	if err := req.Parse(&createRouteRequest); err != nil {
		req.SetError(err)

		return
	}

	common.ApiResponse(req, service.RouteService{}.CreateRoute(req.GetCtx(), createRouteRequest))
}

func (controller Schedule) EditRoute(req *ghttp.Request) {
	editRouteRequest := request.RouteEditReq{}

	if err := req.Parse(&editRouteRequest); err != nil {
		req.SetError(err)

		return
	}

	common.ApiResponse(req, service.RouteService{}.EditRoute(req.GetCtx(), editRouteRequest))
}

// Pretreatment
// @Description: 预处理
// @receiver controller
// @param req
func (controller Schedule) Pretreatment(req *ghttp.Request) {
	pretreatmentReq := request.PretreatmentReq{}

	if err := req.Parse(&pretreatmentReq); err != nil {
		req.SetError(err)

		return
	}

	common.ApiResponse(req, service.TaskService{}.Pretreatment(req.GetCtx(), pretreatmentReq.RouteName, pretreatmentReq.Param, pretreatmentReq.KeyMap, pretreatmentReq.Delay))
}

func (controller Schedule) Confirm(req *ghttp.Request) {
	ConfirmReq := request.ConfirmReq{}

	if err := req.Parse(&ConfirmReq); err != nil {
		req.SetError(err)

		return
	}

	common.ApiResponse(req, service.TaskService{}.Confirm(req.GetCtx(), ConfirmReq.TraceId))
}

func (controller Schedule) Finish(req *ghttp.Request) {
	finishReq := request.FinishReq{}

	if err := req.Parse(&finishReq); err != nil {
		req.SetError(err)

		return
	}

	//req.SetCtxVar(consts.CtxTraceId, finishReq.TraceId)

	common.ApiResponse(req, service.TaskService{}.Finish(req.GetCtx(), finishReq.TraceId, finishReq.KeyMap, finishReq.Param))
}

func (controller Schedule) FindInfo(req *ghttp.Request) {
	finishReq := request.FinishReq{}

	if err := req.Parse(&finishReq); err != nil {
		req.SetError(err)

		return
	}

	req.SetCtxVar(consts.CtxTraceId, finishReq.TraceId)

	common.ApiResponse(req, service.TaskService{}.FindInfo(req.GetCtx(), finishReq.TraceId))
}

func (controller Schedule) Test(req *ghttp.Request) {

	finishReq := request.TestReq{}

	if err := req.Parse(&finishReq); err != nil {
		req.SetError(err)

		return
	}

	param := finishReq.Param

	param[finishReq.TraceId] = finishReq.TraceId

	//service.TaskService{}.Finish(req.GetCtx(),
	//	finishReq.TraceId,
	//	finishReq.KeyMap,
	//	param,
	//)

	common.ApiResponse(req, service.TaskService{}.Finish(req.GetCtx(),
		finishReq.TraceId,
		finishReq.KeyMap,
		param,
	))
}
