#SBATCH --job-name='STARindex_mg38'
#SBATCH --error=STARindex_mg38.error
#SBATCH --output=STARindex_mg38.out
#SBATCH --ntasks=14
#SBATCH --mem=50000MB
#SBATCH --mem-per-cpu=50000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
#!/bin/bash
cd "$SLURM_SUBMIT_DIR"

mkdir STAR_mg38_index
cd STAR_mg38_index

STAR --runThreadN 14 
     --runMode genomeGenerate \
     --genomeFastaFiles ../GRCm38.primary_assembly.genome.fa \
     --genomeDir . \
     --sjdbGTFfile ../gencode.vM16.annotation.gtf \
cd ..
