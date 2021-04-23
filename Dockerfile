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
    && tlmgr install scheme-full