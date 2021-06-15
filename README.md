# sharelatex-full

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/tuetenk0pp/sharelatex-full/Docker%20CI?style=flat-square) ![Docker Pulls](https://img.shields.io/docker/pulls/tuetenk0pp/sharelatex-full?style=flat-square) ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/tuetenk0pp/sharelatex-full?style=flat-square) ![Docker Stars](https://img.shields.io/docker/stars/tuetenk0pp/sharelatex-full?style=flat-square)

Overleaf docker image incuding all packages available with ``tlmgr install scheme-full``

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

## Dockerfile

``` Dockerfile
# based on the work from rigon (https://github.com/rigon/docker-sharelatex-full)
FROM sharelatex/sharelatex:latest

RUN set -x \
    && tlmgr init-usertree \
    # Select closest mirror automatically: http://tug.org/texlive/doc/install-tl.html
    #
    # Latest TeX Live repository
    && tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet/ \
    #
    # From local TeX Live repository
    #&& tlmgr option repository http://nginx/ \
    #
    && tlmgr update --self \
    # https://tex.stackexchange.com/questions/340964/what-do-i-need-to-install-to-make-more-packages-available-under-sharelatex
    #
    && tlmgr update texlive-scripts \
    # https://tex.stackexchange.com/questions/598380/cannot-install-ctex-via-tlmgr-unknown-option-status-file-when-running-fmtuti
    #
    && tlmgr install scheme-full \
    #
    # get minted to work
    # https://github.com/overleaf/overleaf/issues/851#issuecomment-830276429
    && apt-get update \
    && apt-get install python-pygments -y \
    #
    # either put a latexmkrc-file in the root directory of your project:
    #
    # # latexmkrc
    # $pdflatex = 'pdflatex --shell-escape';
    #
    # or enable shell-escape by default:
    && echo % enable shell-escape by default >> /usr/local/texlive/2021/texmf.cnf \
    && echo shell_escape = t >> /usr/local/texlive/2021/texmf.cnf

```


