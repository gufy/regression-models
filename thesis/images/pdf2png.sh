for file in *.pdf; do \
echo $file;\
convert -density 300x300 -resize 320x280 -quality 90 $file `echo $file|cut -f1 -d'.'`.png;\
done
