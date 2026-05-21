target "docker-metadata-action" {}

variable "APP" {
  default = "agentmemory"
}

variable "VERSION" {
  // renovate: datasource=npm depName=@agentmemory/agentmemory
  default = "0.9.21"
}

variable "SOURCE" {
  default = "https://github.com/rohitg00/agentmemory"
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
