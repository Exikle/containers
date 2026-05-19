package main

import (
	"context"
	"testing"

	"github.com/exikle/containers/testhelpers"
)

func Test(t *testing.T) {
	ctx := context.Background()
	image := testhelpers.GetTestImage("ghcr.io/exikle/agentmemory:rolling")
	testhelpers.TestHTTPEndpoint(t, ctx, image, testhelpers.HTTPTestConfig{
		Port: "3111",
		Path: "/agentmemory/health",
	}, nil)
}
