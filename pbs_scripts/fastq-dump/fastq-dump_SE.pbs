#SBATCH --job-name='fastq-dump_SE'
#SBATCH --error=${IN}_fastq-dump_SE.error
#SBATCH --output=${IN}_fastq-dump_SE.out
#SBATCH --ntasks=14
#SBATCH --mem=10000MB
#SBATCH --mem-per-cpu=10000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
#!/bin/bash
cd "$SLURM_SUBMIT_DIR"

fastq-dump -I ../${IN}.sra
