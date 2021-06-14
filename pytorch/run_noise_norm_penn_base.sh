#!/bin/bash

if [[ $1 == 'train' ]]; then
    echo 'Run training...'
    python -W ignore train.py \
        --cuda \
        --data /local/jacques/noisenorm/datasets/penn/ \
        --dataset ptb \
        --n_layer 6 \
        --d_model 512 \
        --n_head 8 \
        --d_head 64 \
        --d_inner 2048 \
        --dropout 0.1 \
        --dropatt 0.0 \
        --optim adam \
        --lr 0.00025 \
        --warmup_step 0 \
        --max_step 1 \
        --tgt_len 128 \
        --mem_len 128 \
        --eval_tgt_len 128 \
        --batch_size 22 \
        --seed 3 \
        --noise_norm \
        # --multi_gpu \
        # --gpu0_bsz 4 \
        ${@:2}
elif [[ $1 == 'eval' ]]; then
    echo 'Run evaluation...'
    python eval.py \
        --cuda \
        --data ../data/enwik8/ \
        --dataset enwik8 \
        --tgt_len 80 \
        --mem_len 2100 \
        --clamp_len 820 \
        --same_length \
        --split test \
        ${@:2}
else
    echo 'unknown argment 1'
fi
