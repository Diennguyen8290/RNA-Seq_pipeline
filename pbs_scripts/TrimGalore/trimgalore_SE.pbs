#SBATCH --job-name='TrimGalore_SE'
#SBATCH --error=${IN}_TrimGalore_SE.error
#SBATCH --output=${IN}_TrimGalore_SE.out
#SBATCH --ntasks=14
#SBATCH --mem=10000MB
#SBATCH --mem-per-cpu=10000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
#!/bin/bash
cd "$SLURM_SUBMIT_DIR"

trim_galore --fastqc ../FASTQ-DUMP/${IN}.fastq
