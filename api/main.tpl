package main

import (
	"flag"
	"fmt"

	{{.importPackages}}
	"github.com/zeromicro/go-zero/core/logx"
	"github.com/zeromicro/go-zero/rest/httpx"
	"github.com/leonlau/go-zero-common/errno"
)

var configFile = flag.String("f", "etc/{{.serviceName}}.yaml", "the config file")

func main() {
	flag.Parse()

	var c config.Config
	conf.MustLoad(*configFile, &c)

	// 关闭 stat 日志
	logx.DisableStat()

	server := rest.MustNewServer(c.RestConf)
	defer server.Stop()

	ctx := svc.NewServiceContext(c)
	handler.RegisterHandlers(server, ctx)

	httpx.SetOkHandler(errno.OkHandler)
	httpx.SetErrorHandlerCtx(errno.ErrorHandler)
	
	fmt.Printf("Starting server at %s:%d...\n", c.Host, c.Port)
	server.Start()
}
