package main

import (
	"testing"
)

func Test(t *testing.T) {
	t.Skip("forgejo-runner requires a live Forgejo instance to function — image build is verified by the bake step")
}
