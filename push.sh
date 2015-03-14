PC=$1;
F=$2;
D=$3;
N=$4;
Settings=$5;

echo "On u-pl"$PC" I'm running simulation for f"$F

COMMAND="cd ~/Documents/MATLAB/regression-models; ./comp.sh "$F" "$D" "$N

T=`date`
LOG="logs/log-"$F"-"$D"-"$N"-"$Settings".txt";

echo $T >>$LOG;

echo $COMMAND
ssh "u-pl"$PC "cd ~/Documents/MATLAB/regression-models; ./comp.sh "$F" "$D" "$N" "$Settings >>$LOG 
#screen -S "pc-"$PC ssh -t "u-pl"$PC "cd ~/Documents/MATLAB/regression-models/; ./comp.sh "$F" "$D" "$N" "$Settings 

