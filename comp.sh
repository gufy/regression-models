F=$1;
D=$2;
N=$3;

screen "cd ~/Documents/MATLAB/regression-models/; ulimit -t unlimited; nice -n 19 /afs/ms/@sys/bin/matlab -nodisplay -r \"try, comp_f(15,5,5000,'settings_gp',1); end; exit\"" &