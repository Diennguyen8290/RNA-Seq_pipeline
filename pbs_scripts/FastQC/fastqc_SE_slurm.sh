#SBATCH --job-name='fastqc_SE'
#SBATCH --error=${IN}_fastqc_SE.error
#SBATCH --output=${IN}_fastqc_SE.out
#SBATCH --ntasks=1
#SBATCH --mem=10000MB
#SBATCH --mem-per-cpu=10000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
#!/bin/bash
cd "$SLURM_SUBMIT_DIR"

fastqc ../FASTQ-DUMP/${IN}.fastq
