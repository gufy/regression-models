# This script is used to start a computation with selected method 
# on selected data set. The script was tested and run at faculty lab
# at Malostranske nam.
#
# This scripts start a shell script ./comp.sh remotely
#

DirWithCode="~/Documents/MATLAB/regressions";
PC=$1;
F=$2;
D=$3;
N=$4;
Settings=$5;
Noisy=$6

echo "On u-pl"$PC" I'm running simulation for f"$F

COMMAND="cd "$DirWithCode"; ./comp.sh "$F" "$D" "$N" "$Settings" "$Noisy

T=`date`
LOG="logs/log-"$F"-"$D"-"$N"-"$Settings"-"$Noisy".txt";

echo $T >>$LOG;

echo $COMMAND
ssh "u-pl"$PC "cd ~/Documents/MATLAB/regressions; ./comp.sh "$F" "$D" "$N" "$Settings" "$Noisy >>$LOG 

