#!/bin/bash
set -e

# Be careful. Do not use any name within this folder!
OUTNAME='author1_author2_author3_short_title_year'

# clean up
rm -rf $OUTNAME
rm -rf $OUTNAME.zip
rm -rf $OUTNAME.pdf
mkdir $OUTNAME

# copy required info
# add here the key files you need for compilation
cp art.tex $OUTNAME/$OUTNAME.tex
cp content.tex $OUTNAME/
cp refs.bib $OUTNAME/
cp myabbrvnat.bst $OUTNAME/

# add here only the figures that are being used in the paper
cp figures/figure1.png $OUTNAME/
cp figures/figure2.pdf $OUTNAME/
# ...

# compile
cd $OUTNAME
se="-shell-escape"
# here specify how you compile your tex (recipe)
# lualatex $se $OUTNAME.tex &&\
# biber    $OUTNAME.aux     &&\
# lualatex $se $OUTNAME.tex &&\
# lualatex $se $OUTNAME.aux     &&\
pdflatex $se $OUTNAME.tex &&\
bibtex    $OUTNAME     &&\
pdflatex $OUTNAME.tex &&\
pdflatex $OUTNAME.tex     &&\

# Clean up
# rm -rf $OUTNAME.aux
# rm -rf $OUTNAME.fls
# rm -rf $OUTNAME.xmk
# rm -rf $OUTNAME.log
# rm -rf $OUTNAME.bak
# rm -rf $OUTNAME.bcf
# rm -rf $OUTNAME.run.xml
# rm -rf $OUTNAME.out
# rm -rf $OUTNAME.synctex.gz
# rm -rf $OUTNAME.toc
# rm -rf $OUTNAME.blg
mv $OUTNAME.pdf ../
cd ..

# Compress it and delete uncompressed folder
tar cvzf $OUTNAME.tar.gz $OUTNAME
rm -rf $OUTNAME
