target "docker-metadata-action" {}

variable "APP" {
  default = "forgesync"
}

variable "VERSION" {
  // renovate: datasource=github-tags depName=eleboucher/forgesync
  default = "0.0.1"
}

variable "SOURCE" {
  default = "https://github.com/eleboucher/forgesync"
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
    "linux/amd64"
  ]
  tags = [
    "${REGISTRY}/${APP}:rolling",
    "${REGISTRY}/${APP}:${VERSION}-${substr(GIT_SHA, 0, 7)}"
  ]
}
