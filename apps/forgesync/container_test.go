package main

import (
	"testing"
)

func Test(t *testing.T) {
	t.Skip("forgesync requires a live Forgejo instance and GitHub token to function — image build is verified by the bake step")
}
