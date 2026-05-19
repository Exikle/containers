target "docker-metadata-action" {}

variable "APP" {
  default = "agentmemory"
}

variable "VERSION" {
  // renovate: datasource=npm depName=@agentmemory/agentmemory
  default = "0.9.20"
}

variable "SOURCE" {
  default = "https://github.com/rohitg00/agentmemory"
}

variable "REGISTRY" {
  default = "ghcr.io/exikle"
}

variable "GIT_SHA" {
  default = "dev"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
  tags = [
    "${REGISTRY}/${APP}:rolling",
    "${REGISTRY}/${APP}:${VERSION}-${substr(GIT_SHA, 0, 7)}"
  ]
}
