#!/bin/bash
#SBATCH --job-name='count'
#SBATCH --error=count.error
#SBATCH --output=count.out
#SBATCH --ntasks=1
#SBATCH --mem=50000MB
#SBATCH --mem-per-cpu=50000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb

cd "$SLURM_SUBMIT_DIR"

samtools view ../STAR/${IN}Aligned.sortedByCoord.out.bam | htseq-count - ../../genome_references/Rattus_norvegicus.Rnor_6.0.91.chr.gtf --stranded=no > count_${IN}.txt
echo 'htseq-count's run has completed' > check_${IN}.txt
