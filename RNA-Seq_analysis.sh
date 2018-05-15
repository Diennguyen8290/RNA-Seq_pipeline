#SET YOUR VARIABLES HERE

#Specify whether the library in question is single-end ('SE') or paired-end ('PE').
library='SE'

#Specify from which organism your data is coming from.  Human='hg38', rat='Rnor6', mouse='mg38'
organism='hg38'

#Specify whether you are starting from .fastq or .sra
start='sra'

#######################################################################################################
if [ ${start} = 'sra' ]; then
  #Convert .sra to .fastq using fastq-dump
  chmod 775 *sra
  mkdir FASTQ-DUMP
  cd FASTQ-DUMP
  for i in $(cat ../accession_list); do
    sbatch --export=IN=${i} --job-name=${i}_fastq-dump_${library} --output=${i}_fastq-dump_${library}.out --error=${i}_fastq-dump_${library}.error ../../slurm_scripts/fastq-dump/fastq-dump_${library}.slurm
  done
  for i in $(cat ../accession_list); do
    until [ -f ${i}_fastq-dump_${library}.error ]; do
      sleep 5
    done
  done
  cd ..
elif [ ${start} = 'fastq' ]; then
  echo 'Skipping fastq-dump...'
else
  echo 'Please specify whether your starting point is .sra or .fastq file format.'
fi

#FASTQC
mkdir FASTQC
cd FASTQC

for i in $(cat ../accession_list); do
  sbatch --export=IN=${i} --job-name=${i}_fastqc_${library} --output=${i}_fastqc_${library}.out --error=${i}_fastqc_${library}.error ../../slurm_scripts/FastQC/fastqc_${library}.slurm;
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
  sbatch --export=IN=${i}  --job-name=${i}_TrimGalore_{library} --output=${i}_TrimGalore_${library}.out --error=${i}_TrimGalore_${library}.error ../../slurm_scripts/TrimGalore/trimgalore_${library}.slurm;
done

for i in $(cat ../accession_list); do
  until [ -f ${i}_trimmed_fastqc.html ]; do
    sleep 1m
  done
done

cd ..

#STAR
mkdir STAR
cd STAR

for i in $(cat ../accession_list); do
  sbatch --export=IN=${i} --job-name=${i}_STAR_${organism}_${library} --error=${i}_STAR_${organism}_${library}.error --output=${i}_STAR_${organism}_${library}.out ../../slurm_scripts/STAR/STAR_${organism}_${library}.slurm;
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
  sbatch --export=IN=${i} --job-name=${i}_count --error=${i}_count.error --output=${i}_count.out ../../slurm_scripts/HTSeq/htseq_${organism}.slurm;
done
