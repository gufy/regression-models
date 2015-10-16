# This script is run at remote destination where Matlab is running.

F=$1;
D=$2;
N=$3;
Settings=$4;
Noisy=$5

cd ~/Documents/MATLAB/regressions/

# disable limits for CPU time
ulimit -t unlimited

# start Matlab and run the script, but be friendly to other processes
nice -n 19 /afs/ms/@sys/bin/matlab -nodisplay -r "try, comp_f("$F","$D","$N",'"$Settings"',0,"$Noisy"); end; exit" &