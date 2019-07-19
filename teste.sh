#!/bin/bash

runTuning.py -d /volume/mc16a.zee.20M.jf17.20M.offline.binned.calo.wdatadrivenlh.npz \
    -x /home/caducovas/run/crossValid_SAE_jackknife.pic \
    --neuronBounds 10 10 \
    --initBounds 0 5 \
    --sortBounds 0 1 \
    --et-bins 1 1 \
    --eta-bins 1 1 \
    --output-level DEBUG \
    --operation Offline_LH_VeryLoose  \
    --ppFile /home/caducovas/run/ppFile_preproc.pic \
