# sharelatex-full (Overleaf)

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/tuetenk0pp/sharelatex-full/Docker%20build%20and%20push%20release?style=flat-square) ![Docker Pulls](https://img.shields.io/docker/pulls/tuetenk0pp/sharelatex-full?style=flat-square) ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/tuetenk0pp/sharelatex-full?style=flat-square) ![Docker Stars](https://img.shields.io/docker/stars/tuetenk0pp/sharelatex-full?style=flat-square)

Overleaf docker image incuding all packages available with ``tlmgr install scheme-full`` and minted support

## Installation

### Overleaf Toolkit

Ideally, you would use the [Overleaf Toolkit](https://github.com/overleaf/toolkit) as described [here](https://github.com/overleaf/toolkit/blob/master/doc/configuration.md#the-docker-composeoverrideyml-file) with a [docker-compose.override.yaml](./docker-compose.override.yaml). Example:
``` yaml
services:
    sharelatex:
        image: tuetenk0pp/sharelatex-full
```

### Docker Compose

Alternatively, use the [docker-compose.yaml](https://github.com/overleaf/overleaf/blob/master/docker-compose.yml) provided in the [official GitHub](https://github.com/overleaf/overleaf), but change the image to ``tuetenk0pp/sharelatex-full``.
