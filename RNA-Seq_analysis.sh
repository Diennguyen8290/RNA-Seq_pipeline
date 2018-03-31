#SET YOUR VARIABLES HERE

#Specify whether the library in question is single-end ('SE') or paired-end ('PE').
library='SE or PE'

#Specify from which organism your data is coming from.  Human='hg38', rat='Rnor6', mouse='mg38' 
organism='hg38 or Rnor6 or mg38'

#######################################################################################################
chmod 775 *sra

#FASTQ-DUMP
mkdir FASTQ-DUMP
cd FASTQ-DUMP

for i in $(cat ../accession_list); do
  sbatch --export=IN=${i} ../../pbs_scripts/fastq-dump/fastq-dump_${library}_slurm.sh &
done

for i in $(cat ../accession_list); do
  until [ -f ${i}_fastq-dump_${library}.error ]; do
    sleep 5
  done
done

cd ..

#FASTQC
mkdir FASTQC
cd FASTQC

for i in $(cat ../accession_list); do
  qsub --export=IN=${i} ../../pbs_scripts/FastQC/fastqc_${library}_slurm.sh &
done

for i in $(cat ../accession_list); do
  until [ -f ${i}_fastqc_${library}.error ]; do
    sleep 5
  done
done

cd ..

#TRIMGALORE!
mkdir TRIMGALORE
cd TRIMGALORE

for i in $(cat ../accession_list); do
  sbatch --export=IN=${i}  ../../pbs_scripts/TrimGalore/trimgalore_${library}_slurm.sh &
done

for i in $(cat ../accession_list); do
  until [ -f ${i}_TrimGalore_${library}.error ]; do
    sleep 1m
  done
done

cd ..

#STAR
mkdir STAR
cd STAR

for i in $(cat ../accession_list); do
  sbatch --export=IN=${i} ../../pbs_scripts/STAR/STAR_${organism}_${library}_slurm.sh &
done

for i in $(cat ../accession_list); do
  until [ -f ${i}Log.final.out ]; do
    sleep 1m
  done
done

cd ..

#HTSeq
mkdir HTSeq
cd HTSeq

for i in $(cat ../accession_list); do
  sbatch --export=IN=${i} ../../pbs_scripts/HTSeq/htseq_${organism}_slurm.sh &
done
