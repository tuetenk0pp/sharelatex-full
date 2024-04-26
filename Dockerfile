# based on the work from rigon (https://github.com/rigon/docker-sharelatex-full)
FROM sharelatex/sharelatex:5.0.3

SHELL ["/bin/bash", "-cx"]

# update tlmgr itself
RUN wget "https://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh" \
    && sh update-tlmgr-latest.sh \
    && tlmgr --version
#
# initialize usertree to allow user-mode
#RUN tlmgr init-usertree
#
# enable tlmgr to install ctex
# https://tex.stackexchange.com/questions/598380/cannot-install-ctex-via-tlmgr-unknown-option-status-file-when-running-fmtuti
RUN tlmgr update texlive-scripts 
#
# update packages
RUN tlmgr update --all
#
# install all the packages
# https://tex.stackexchange.com/questions/340964/what-do-i-need-to-install-to-make-more-packages-available-under-sharelatex
RUN tlmgr install scheme-full
#
# recreate symlinks
# https://www.tug.org/texlive/doc/tlmgr.html#path
RUN tlmgr path add
#
# update system packages
RUN apt-get update && apt-get upgrade -y
#
# install minted dependency
# https://github.com/overleaf/overleaf/issues/851#issuecomment-830276429
RUN apt-get install python3-pygments -y
#
# install inkscape for svg support
RUN apt-get install inkscape -y
#
# install lilypond
RUN apt-get install lilypond -y
#
# either put a latexmkrc-file in the root directory of your project:
#
# # latexmkrc
# $pdflatex = 'pdflatex --shell-escape';
#
# or enable shell-escape by default:
RUN TEXLIVE_FOLDER=$(find /usr/local/texlive/ -type d -name '20*') \
    && echo % enable shell-escape by default >> /$TEXLIVE_FOLDER/texmf.cnf \
    && echo shell_escape = t >> /$TEXLIVE_FOLDER/texmf.cnf
