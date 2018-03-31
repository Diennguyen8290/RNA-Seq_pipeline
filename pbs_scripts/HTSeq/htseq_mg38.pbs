#SBATCH --job-name='count'
#SBATCH --error=${IN}_count.error
#SBATCH --output=${IN}_count.out
#SBATCH --ntasks=1
#SBATCH --mem=50000MB
#SBATCH --mem-per-cpu=50000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
#!/bin/bash
cd "$SLURM_SUBMIT_DIR"

samtools view ../STAR/${IN}Aligned.sortedByCoord.out.bam | htseq-count - ../../genome_references/gencode.vM16.annotation.gtf --stranded=no > count_${IN}.txt
