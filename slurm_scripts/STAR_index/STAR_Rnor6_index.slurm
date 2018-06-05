#!/bin/bash
#SBATCH --ntasks=14
#SBATCH --mem=50000MB
#SBATCH --mem-per-cpu=50000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
cd "$SLURM_SUBMIT_DIR"

mkdir STAR_Rnor6_index
cd STAR_Rnor6_index

STAR --runThreadN 14 \
     --runMode genomeGenerate \
     --genomeFastaFiles ../genome_references/Rattus_norvegicus.Rnor_6.0.dna.toplevel.fa \
     --genomeDir $PWD \
     --sjdbGTFfile ../genome_references/Rattus_norvegicus.Rnor_6.0.91.chr.gtf \
cd ..
