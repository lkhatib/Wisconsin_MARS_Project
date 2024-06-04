#!/bin/bash
#SBATCH --chdir=/home/lakhatib/Wisconsin_MARS/metagenomics/birdman/apoe4/species/scripts
#SBATCH --output=/home/lakhatib/Wisconsin_MARS/metagenomics/birdman/apoe4/species/slurm_out/%x.%a.out
#SBATCH --partition=short
#SBATCH --mail-user="lakhatib@ucsd.edu"
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mem=64G
#SBATCH --nodes=1
#SBATCH --partition=short
#SBATCH --cpus-per-task=4
#SBATCH --time=20:00:00
#SBATCH --array=1-10

pwd; hostname; date

set -e

# REPLACE WITH YOUR ENVIRONMENT NAME
source /home/lakhatib/miniconda3/bin/activate birdman

echo Chunk $SLURM_ARRAY_TASK_ID / $SLURM_ARRAY_TASK_MAX

# REPLACE WITH YOUR FILEPATHS
path='/home/lakhatib/Wisconsin_MARS/metagenomics/birdman/apoe4/species'
TABLEID="apoe4_birdman_l7_ft"

TABLE="/home/lakhatib/Wisconsin_MARS/metagenomics/data/apoe4/"$TABLEID".biom"
SLURMS=""$path"/slurm_out/"$TABLEID
OUTDIR=""$path"/inferences/"$TABLEID
LOGDIR=""$path"/logs/"$TABLEID
mkdir -p $SLURMS
mkdir -p $OUTDIR
mkdir -p $LOGDIR

echo Starting Python script...
# REPLACE WITH YOUR SCRIPT PATH 
time python birdman_chunked.py \
    --table-path $TABLE \
    --inference-dir $OUTDIR \
    --num-chunks $SLURM_ARRAY_TASK_MAX \
    --chunk-num $SLURM_ARRAY_TASK_ID \
    --logfile "${LOGDIR}/chunk_${SLURM_ARRAY_TASK_ID}.log" && echo Finished Python script!
