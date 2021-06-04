ENV="Sokoban-$1"
SEED=${2-"0"}
GPU=${3-"-1"}
OUTDIR_LABEL=${4-"discor-uer"}
NET_ARCH=${5-"large_atari"}
LR=${6-"3e-4"}
TARGET_UPDATE_INTERVAL=${7-"10000"}
STEPS=${8-10000000}
EXTRA_ARGS=${@:9}

echo "Env: $ENV"
echo "Outdir label: $OUTDIR_LABEL"
echo "Seed: $SEED"
echo "GPU: $GPU"
echo "Learning rate: $LR"
echo "Net arch: $NET_ARCH"
echo "Steps: $STEPS"

if [[ $NET_ARCH -eq "large_atari" ]]
then    
    if [[ $TARGET_UPDATE_INTERVAL -ge "10000" ]]
    then
        REPLAY_START_SIZE=50000
    else
        REPLAY_START_SIZE=20000 
    fi
else
    REPLAY_START_SIZE=5000
fi
echo "Replay start size: $REPLAY_START_SIZE"
echo "Target update interval: ${TARGET_UPDATE_INTERVAL}"

python scripts/train_dqn.py \
    --gpu $GPU \
    --algo DISCOR-DDQN \
    --replay UER \
    --net-arch $NET_ARCH \
    --explorer linear-decay \
    --outdir results/sokoban/ddqn-$OUTDIR_LABEL-lr_${LR}-tu_${TARGET_UPDATE_INTERVAL}/$NET_ARCH/$ENV \
    --env $ENV \
    --steps $STEPS \
    --lr $LR \
    --noise-eval 0.01 \
    --monitor \
    --eval-n-runs 100 \
    --eval-interval 100000 \
    --update-interval 4 \
    --target-update-interval $TARGET_UPDATE_INTERVAL \
    --final-exploration-steps 1000000 \
    --start-epsilon 1.0 \
    --end-epsilon 0.01 \
    --replay-start-size $REPLAY_START_SIZE \
    --replay-capacity 1000000 \
    --batch-size 32 --seed $SEED $EXTRA_ARGS