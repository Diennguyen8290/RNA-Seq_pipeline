#SBATCH --job-name='STAR_Rnor6_PE'
#SBATCH --error=${IN}_STAR_Rnor6_PE.error
#SBATCH --output=${IN}_STAR_Rnor6_PE.out
#SBATCH --ntasks=14
#SBATCH --mem=50000MB
#SBATCH --mem-per-cpu=50000MB
#SBATCH --time=10:00:00
#SBATCH --partition=cmb
#!/bin/bash
cd "$SLURM_SUBMIT_DIR"

ref_genome=../../STAR_Rnor6_index

STAR --outFileNamePrefix ${IN} \
      --quantMode GeneCounts \
      --readFilesCommand cat \
      --outSAMtype BAM SortedByCoordinate \
      --bamRemoveDuplicatesType UniqueIdentical \
      --runThreadN 14 \
      --outBAMsortingThreadN 14 \
      --outWigType wiggle \
      --outWigStrand Unstranded \
      --outWigNorm None \
      --genomeDir ${ref_genome} \
      --readFilesIn ../TRIMGALORE/${IN}_1_val_1.fq ../TRIMGALORE/${IN}_2_val_2.fq
