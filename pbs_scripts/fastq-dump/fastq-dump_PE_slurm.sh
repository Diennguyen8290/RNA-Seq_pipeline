#SBATCH --job-name='fastq-dump_PE'
#SBATCH --error=${IN}_fastq-dump_PE.error
#SBATCH --output=${IN}_fastq-dump_PE.out
#SBATCH --ntasks=14
#SBATCH --mem=10000MB
#SBATCH --mem-per-cpu=10000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
#!/bin/bash
cd "$SLURM_SUBMIT_DIR"

fastq-dump --split-files -I ../${IN}.sra
