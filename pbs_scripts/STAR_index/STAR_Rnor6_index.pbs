#SBATCH --job-name='STARindex_Rnor6'
#SBATCH --error=STARindex_Rnor6.error
#SBATCH --output=STARindex_Rnor6.out
#SBATCH --ntasks=14
#SBATCH --mem=50000MB
#SBATCH --mem-per-cpu=50000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
#!/bin/bash
cd "$SLURM_SUBMIT_DIR"

mkdir STAR_Rnor6_index
cd STAR_Rnor6_index

STAR --runThreadN 14
     --runMode genomeGenerate \
     --genomeFastaFiles ../GCF_000001895.5_Rnor_6.0_genomic.fa \
     --genomeDir $PWD \
     --sjdbGTFfile ../Rattus_norvegicus.Rnor_6.0.91.chr.gtf \
cd ..
