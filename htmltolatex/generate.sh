#!/usr/bin/env sh

# Some directories we need
dir=$(pwd)

if [ $(uname) == "Linux" ]; then
    htmltolatexdir=/home/barrymoo/src/htmltolatex-1.0.1
elif [ $(uname) == "Darwin" ]; then
    sed(){
        gsed "$@"
    }
    export -f sed
    htmltolatexdir=/Users/bmooreii/src/htmltolatex-1.0.1
fi

# Clean directory
rm index.aux index.log index.out

# Make LaTeX subsitution
sed "s/<span class=\"latex\">L<sup>a<\/sup>T<sub>e<\/sub>X<\/span>/LaTeX/" $dir/../index.html > $dir/index.html

# Create the initial tex document
cd $htmltolatexdir
./htmltolatex -input $dir/index.html -output $dir/index.tex -css $dir/style.css -config $dir/config.xml

# Go back
cd $dir

# need to add reverse enumerate package!

# Make some substitutions
sed -i -e "s/LaTeX/\\\LaTeX\\\ /" \
       -e "s/\(\%\ \ Section:\ Education\)/\\\rule{\\\textwidth}{0\.5pt}\n\1/" \
       -e "s/\\\ ,/,/" -e "s/\\\ \././" \
       -e "s/including\ this\ document/generated from \\\href{http:\/\/barrymoo.github.io\/cv}{barrymoo.github.io\/cv}/" \
       -e '/usepackage{stix}/a \\\usepackage{etaremune}' \
       -e "s/enumerate/etaremune/" \
    $dir/index.tex

# Run pdflatex
pdflatex index.tex
pdflatex index.tex
pdflatex index.tex
