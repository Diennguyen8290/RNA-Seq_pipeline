#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem=50000MB
#SBATCH --mem-per-cpu=50000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
cd "$SLURM_SUBMIT_DIR"

samtools view ../STAR/${IN}Aligned.sortedByCoord.out.bam | htseq-count - ../../genome_references/gencode.v27.annotation.gtf --stranded=no > count_${IN}.txt
echo 'I think this will work' > check_${IN}.txt
