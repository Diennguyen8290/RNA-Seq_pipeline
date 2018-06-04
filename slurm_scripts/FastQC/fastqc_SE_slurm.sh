#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem=10000MB
#SBATCH --mem-per-cpu=10000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb

cd "$SLURM_SUBMIT_DIR"

fastqc ../FASTQ-DUMP/${IN}.fastq
