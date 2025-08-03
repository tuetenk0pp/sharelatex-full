FROM sharelatex/sharelatex:5.5.4

SHELL ["/bin/bash", "-cx"]

# update tlmgr itself
RUN wget "https://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh" \
    && sh update-tlmgr-latest.sh \
    && tlmgr --version

# enable tlmgr to install ctex
RUN tlmgr update texlive-scripts 

# update packages
RUN tlmgr update --all

# install all the packages
RUN tlmgr install scheme-full

# recreate symlinks
RUN tlmgr path add

# update system packages
RUN apt-get update && apt-get upgrade -y

# install inkscape for svg support
RUN apt-get install inkscape -y

# install lilypond
RUN apt-get install lilypond -y

# enable shell-escape by default:
RUN TEXLIVE_FOLDER=$(find /usr/local/texlive/ -type d -name '20*') \
    && echo % enable shell-escape by default >> /$TEXLIVE_FOLDER/texmf.cnf \
    && echo shell_escape = t >> /$TEXLIVE_FOLDER/texmf.cnf
