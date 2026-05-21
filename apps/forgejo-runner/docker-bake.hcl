target "docker-metadata-action" {}

variable "APP" {
  default = "forgejo-runner"
}

variable "VERSION" {
  // renovate: datasource=github-tags depName=eleboucher/runner
  default = "12.10.1"
}

variable "SOURCE" {
  default = "https://github.com/eleboucher/runner"
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
}
