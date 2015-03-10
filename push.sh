PC=$1;
F=$2;
D=$3;
N=$4;

echo "On u-pl"$PC" I'm running simulation for f"$F

COMMAND="screen ./comp.sh "$F $D $N;

ssh "u-pl"$PC $COMMAND