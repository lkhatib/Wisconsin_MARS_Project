#!/bin/bash

# Submit the first script as an array job and capture its job ID
ARRAY_JOB_ID=$(sbatch --parsable --array=1-10 species_birdman.sh)

# Submit the second script with a dependency on the entire array job completion
sbatch --dependency=afterok:$ARRAY_JOB_ID summarize-inferences.sh
