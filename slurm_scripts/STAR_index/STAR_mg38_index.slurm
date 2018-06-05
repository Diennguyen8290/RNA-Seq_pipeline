#!/bin/bash
#SBATCH --ntasks=14
#SBATCH --mem=50000MB
#SBATCH --mem-per-cpu=50000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
cd "$SLURM_SUBMIT_DIR"

mkdir STAR_mg38_index
cd STAR_mg38_index

STAR --runThreadN 14 \
     --runMode genomeGenerate \
     --genomeFastaFiles ../GRCm38.primary_assembly.genome.fa \
     --genomeDir . \
     --sjdbGTFfile ../gencode.vM16.annotation.gtf \
cd ..
