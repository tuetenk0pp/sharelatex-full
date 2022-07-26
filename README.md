# sharelatex-full (Overleaf)

[![GitHub license](https://img.shields.io/github/license/Tuetenk0pp/sharelatex-full)](https://github.com/Tuetenk0pp/sharelatex-full/blob/master/LICENSE) 
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/Tuetenk0pp/sharelatex-full/Docker%20build%20and%20push%20release)](https://github.com/Tuetenk0pp/sharelatex-full/actions/workflows/build%20and%20push%20release.yml)
[![GitHub issues](https://img.shields.io/github/issues/tuetenk0pp/sharelatex-full)](https://github.com/Tuetenk0pp/sharelatex-full/issues)
[![Docker Pulls](https://img.shields.io/docker/pulls/tuetenk0pp/sharelatex-full)](https://hub.docker.com/r/tuetenk0pp/sharelatex-full)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/tuetenk0pp/sharelatex-full)](https://hub.docker.com/r/tuetenk0pp/sharelatex-full)
[![Docker Stars](https://img.shields.io/docker/stars/tuetenk0pp/sharelatex-full)](https://hub.docker.com/r/tuetenk0pp/sharelatex-full)
[![Docker Image Version (latest by date)](https://img.shields.io/docker/v/tuetenk0pp/sharelatex-full)](https://hub.docker.com/r/tuetenk0pp/sharelatex-full)

Overleaf docker image incuding all packages available with ``tlmgr install scheme-full`` and minted support.
Inkscape is added for `svg`-image support.
Have a look at the [Dockerfile](Dockerfile) to find out more.

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
