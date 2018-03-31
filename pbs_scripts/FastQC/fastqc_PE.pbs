#SBATCH --job-name='fastqc_PE'
#SBATCH --error=${IN}_fastqc_PE.error
#SBATCH --output=${IN}_fastqc_PE.out
#SBATCH --ntasks=1
#SBATCH --mem=10000MB
#SBATCH --mem-per-cpu=10000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
#!/bin/bash
cd "$SLURM_SUBMIT_DIR"

fastqc ../FASTQ-DUMP/${IN}_1.fastq
fastqc ../FASTQ-DUMP/${IN}_2.fastq
