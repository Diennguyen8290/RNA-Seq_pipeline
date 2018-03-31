#SBATCH --job-name='STARindex_hg38'
#SBATCH --error=STARindex_hg38.error
#SBATCH --output=STARindex_hg38.out
#SBATCH --ntasks=14
#SBATCH --mem=50000MB
#SBATCH --mem-per-cpu=50000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
#!/bin/bash
cd "$SLURM_SUBMIT_DIR"

mkdir STAR_hg38_index
cd STAR_hg38_index

STAR --runThreadN 14 
     --runMode genomeGenerate \
     --genomeFastaFiles ../GRCh38.primary_assembly.genome.fa \
     --genomeDir $PWD \
     --sjdbGTFfile ../gencode.v27.annotation.gtf \

cd ..
