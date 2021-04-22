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
#
# Install TeX Live: metapackage pulling in all components of TeX Live
# Wofür!?
#RUN set -x \
    #&& apt-get update 
    #&& apt-get install -y texlive-full
#
# Install Pygments for minted
#RUN set -x \
#    && apt-get update \
#    && apt-get install -y xzdec python-pygments
#
# For some reason, European Portuguese is not installed
#RUN set -x \
#    && wget http://natura.di.uminho.pt/download/sources/Dictionaries/aspell6/aspell6.pt-20171225.tar.bz2 \
#    && tar xf aspell6.pt-20171225.tar.bz2 \
#   && cd aspell6-pt_PT-20171225-0/ \
#    && ./configure \
#    && make \
#    && make install \
#    && cd .. \
#    && rm -rf aspell6.pt-20171225.tar.bz2 aspell6-pt_PT-20171225-0/
#
# -shell-escape is required by minted
# https://github.com/sharelatex/sharelatex-docker-image/issues/45#issuecomment-247809588
#RUN sed -i 's/concat(\[\"-pdf\",/concat(\[\"-pdf\",\"-shell-escape\",/g' /var/www/sharelatex/clsi/app/js/LatexRunner.js