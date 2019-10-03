#!/bin/bash
echo "Descargando paquetes necesarios"
yum -y install texlive-collection-fontsrecommended texlive-collection-latexrecommended texlive-changepage texlive-titlesec
mkdir -p /usr/share/texlive/texmf-local/tex/latex/comment
cd /usr/share/texlive/texmf-local/tex/latex/comment
wget http://mirrors.ctan.org/macros/latex/contrib/comment/comment.sty
chmod 644 comment.sty
texhash
