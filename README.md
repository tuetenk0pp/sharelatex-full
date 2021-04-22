# sharelatex-full

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/tuetenk0pp/sharelatex-full/Docker%20CI?style=flat-square) ![Docker Pulls](https://img.shields.io/docker/pulls/tuetenk0pp/sharelatex-full?style=flat-square) ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/tuetenk0pp/sharelatex-full?style=flat-square)

Overleaf docker image incuding all packages available with ``tlmgr install scheme-full``

## Installation

Just like the official Overleaf docker container. You can use the [docker-compose.yaml](https://github.com/overleaf/overleaf/blob/master/docker-compose.yml) provided in the [official GitHub](https://github.com/overleaf/overleaf), but change the image to ``tuetenk0pp/sharelatex-full``.

### Dockerfile

``` Dockerfile
FROM sharelatex/sharelatex

# This must be before install texlive-full
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
    && tlmgr install scheme-full

```

### docker-compose

``` yaml
version: '2.2'
services:
    sharelatex-full:
        restart: always
        image: tuetenk0pp/sharelatex-full:latest
        container_name: sharelatex-full
        depends_on:
            - mongo
            - redis
        ports:
            - 80:80
        links:
            - mongo
            - redis
        volumes:
            - ~/sharelatex_data:/var/lib/sharelatex
        environment:

            SHARELATEX_APP_NAME: Overleaf Community Edition

            SHARELATEX_MONGO_URL: mongodb://mongo/sharelatex

            # Same property, unfortunately with different names in
            # different locations
            SHARELATEX_REDIS_HOST: redis
            REDIS_HOST: redis

            ENABLED_LINKED_FILE_TYPES: 'url,project_file'

            # Enables Thumbnail generation using ImageMagick
            ENABLE_CONVERSIONS: 'true'

            # Disables email confirmation requirement
            EMAIL_CONFIRMATION_DISABLED: 'true'

            # temporary fix for LuaLaTex compiles
            # see https://github.com/overleaf/overleaf/issues/695
            TEXMFVAR: /var/lib/sharelatex/tmp/texmf-var

            ## Set for SSL via nginx-proxy
            #VIRTUAL_HOST: 103.112.212.22

            # SHARELATEX_SITE_URL: http://sharelatex.mydomain.com
            # SHARELATEX_NAV_TITLE: Our ShareLaTeX Instance
            # SHARELATEX_HEADER_IMAGE_URL: http://somewhere.com/mylogo.png
            # SHARELATEX_ADMIN_EMAIL: support@it.com

            # SHARELATEX_LEFT_FOOTER: '[{"text": "Powered by <a href=\"https://www.sharelatex.com\">ShareLaTeX</a> 2016"},{"text": "Another page I want to link to can be found <a href=\"here\">here</a>"} ]'
            # SHARELATEX_RIGHT_FOOTER: '[{"text": "Hello I am on the Right"} ]'

            # SHARELATEX_EMAIL_FROM_ADDRESS: "team@sharelatex.com"

            # SHARELATEX_EMAIL_AWS_SES_ACCESS_KEY_ID:
            # SHARELATEX_EMAIL_AWS_SES_SECRET_KEY:

            # SHARELATEX_EMAIL_SMTP_HOST: smtp.mydomain.com
            # SHARELATEX_EMAIL_SMTP_PORT: 587
            # SHARELATEX_EMAIL_SMTP_SECURE: false
            # SHARELATEX_EMAIL_SMTP_USER:
            # SHARELATEX_EMAIL_SMTP_PASS:
            # SHARELATEX_EMAIL_SMTP_TLS_REJECT_UNAUTH: true
            # SHARELATEX_EMAIL_SMTP_IGNORE_TLS: false
            # SHARELATEX_EMAIL_SMTP_NAME: '127.0.0.1'
            # SHARELATEX_EMAIL_SMTP_LOGGER: true
            # SHARELATEX_CUSTOM_EMAIL_FOOTER: "This system is run by department x"

    mongo:
        restart: always
        image: mongo:4.0
        container_name: mongo
        expose:
            - 27017
        volumes:
            - ~/mongo_data:/data/db
        healthcheck:
            test: echo 'db.stats().ok' | mongo localhost:27017/test --quiet
            interval: 10s
            timeout: 10s
            retries: 5

    redis:
        restart: always
        image: redis:5
        container_name: redis
        expose:
            - 6379
        volumes:
            - ~/redis_data:/data


    # See https://github.com/jwilder/nginx-proxy for documentation on how to configure the nginx-proxy container,
    # and https://github.com/overleaf/overleaf/wiki/HTTPS-reverse-proxy-using-Nginx for an example of some recommended
    # settings. We recommend using a properly managed nginx instance outside of the Overleaf Server Pro setup,
    # but the example here can be used if you'd prefer to run everything with docker-compose

    # nginx-proxy:
    #     image: jwilder/nginx-proxy
    #     container_name: nginx-proxy
    #     ports:
    #       #- "80:80"
    #       - "443:443"
    #     volumes:
    #       - /var/run/docker.sock:/tmp/docker.sock:ro
    #       - /home/sharelatex/tmp:/etc/nginx/certs

```



