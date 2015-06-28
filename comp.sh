F=$1;
D=$2;
N=$3;
Settings=$4;
Noisy=$5

cd ~/Documents/MATLAB/regression-models/
ulimit -t unlimited
nice -n 19 /afs/ms/@sys/bin/matlab -nodisplay -r "try, comp_f("$F","$D","$N",'"$Settings"',1,"$Noisy"); end; exit" &