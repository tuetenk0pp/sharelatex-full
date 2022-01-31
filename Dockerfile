# based on the work from rigon (https://github.com/rigon/docker-sharelatex-full)
FROM sharelatex/sharelatex:latest

RUN set -x \
    # initialize usertree to allow user-mode
    && echo "*** Initialize usertree to allow user-mode. ***" \
    && tlmgr init-usertree \
    #
    # Select closest mirror automatically: http://tug.org/texlive/doc/install-tl.html
    && echo "*** Select closest mirror for package downloads. ***" \
    && tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet/ \
    #
    # update tlmgr itself
    && echo "*** Update tlmgr itself. ***" \
    && tlmgr update --self \
    #
    # enable tlmgr to install ctex
    # https://tex.stackexchange.com/questions/598380/cannot-install-ctex-via-tlmgr-unknown-option-status-file-when-running-fmtuti
    && echo "*** Enable tlmgr to install ctex. ***" \
    && tlmgr update texlive-scripts \
    #
    # install all the packages
    # https://tex.stackexchange.com/questions/340964/what-do-i-need-to-install-to-make-more-packages-available-under-sharelatex
    && echo "*** Install all the packages. This might take a while. ***" \
    && tlmgr install scheme-full \
    #
    # get minted to work
    # https://github.com/overleaf/overleaf/issues/851#issuecomment-830276429
    && echo "*** Install python-pygments (minted dependency). ***" \
    && apt-get update \
    && apt-get install python-pygments -y \
    #
    # either put a latexmkrc-file in the root directory of your project:
    #
    # # latexmkrc
    # $pdflatex = 'pdflatex --shell-escape';
    #
    # or enable shell-escape by default:
    && echo "*** Enable shell-escape. ***" \
    && echo % enable shell-escape by default >> /usr/local/texlive/2021/texmf.cnf \
    && echo shell_escape = t >> /usr/local/texlive/2021/texmf.cnf
