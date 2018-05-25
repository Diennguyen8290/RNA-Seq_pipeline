######SET YOUR VARIABLES HERE#####

#Specify whether the library in question is single-end ('SE') or paired-end ('PE').
library='SE or PE'

#Specify from which organism your data is coming from.  Human='hg38', rat='Rnor6', mouse='mg38'
organism='hg38, Rnor6, or mg38'

#Specify whether you are starting from .fastq (fastq) or .sra (sra)
start='fastq or sra'

#Specify by what genome feature you want to base your protein-coding genes off of (i.e. 'gene', 'transcript', or 'CDS')
feature='gene, transcript, or CDS'

#######################################################################################################
if [ ${start} = 'sra' ]; then
  ################################################################################################################
  #CONVERT .SRA FILES TO .FASTQ FORMAT
  ################################################################################################################
  chmod 775 *sra
  mkdir FASTQ-DUMP
  cd FASTQ-DUMP
  for i in $(cat ../accession_list); do
    sbatch --export=IN=${i} --job-name=fastq-dump_${library} --output=${i}_fastq-dump_${library}.out --error=${i}_fastq-dump_${library}.error ../../slurm_scripts/fastq-dump/fastq-dump_${library}.slurm
  done

  for i in $(cat ../accession_list); do
    until [ -f check_${i}.txt ]; do
      sleep 1m
    done
  done

  rm check*txt

  cd ..

elif [ ${start} = 'fastq' ]; then
  echo 'Skipping fastq-dump...'
else
  echo 'Please specify whether your starting point is .sra or .fastq file format.'
fi

################################################################################################################
#ASSESS READ QUALITY AND ADAPTER CONTENT USING FASTQC
################################################################################################################
mkdir FASTQC
cd FASTQC

for i in $(cat ../accession_list); do
  sbatch --export=IN=${i} --job-name=fastqc_${library} --output=${i}_fastqc_${library}.out --error=${i}_fastqc_${library}.error ../../slurm_scripts/FastQC/fastqc_${library}.slurm;
done

for i in $(cat ../accession_list); do
  until [ -f ${i}_fastqc_${library}.error ]; do
    sleep 5
  done
done

cd ..

################################################################################################################
#REMOVE ADAPTERS FROM THE RAW FASTQ FILES AND TRIM FOR QUALITY USING TRIMGALORE!
################################################################################################################
mkdir TRIMGALORE
cd TRIMGALORE

for i in $(cat ../accession_list); do
  sbatch --export=IN=${i}  --job-name=TrimGalore_{library} --output=${i}_TrimGalore_${library}.out --error=${i}_TrimGalore_${library}.error ../../slurm_scripts/TrimGalore/trimgalore_${library}.slurm;
done

if [ ${library} = 'SE' ]; then
  for i in $(cat ../accession_list); do
    until [ -f ${i}_trimmed_fastqc.html ]; do
      sleep 1m
    done
  done
elif [ ${library} = 'PE' ]; then
  for i in $(cat ../accession_list); do
    until [ -f ${i}_2_val_2_fastqc.html ]; do
      sleep 1m
    done
  done
else
  echo 'Please specify whether your library is composed of single-end or paired-end reads'
fi

cd ..

################################################################################################################
#MAP TRIMMED READS TO THE REFERENCE GENOME USING STAR
################################################################################################################
mkdir STAR
cd STAR

for i in $(cat ../accession_list); do
  sbatch --export=IN=${i} --job-name=STAR_${organism}_${library} --error=${i}_STAR_${organism}_${library}.error --output=${i}_STAR_${organism}_${library}.out ../../slurm_scripts/STAR/STAR_${organism}_${library}.slurm;
done

for i in $(cat ../accession_list); do
  until [ -f ${i}Log.final.out ]; do
    sleep 1m
  done
done

cd ..

################################################################################################################
#CONVERT .BAM OUTPUT FROM STAR INTO RAW GENE COUNT MATRICES USING HTSEQ-COUNT
################################################################################################################
mkdir HTSeq
cd HTSeq

for i in $(cat ../accession_list); do
  sbatch --export=IN=${i} --job-name=count --error=${i}_count.error --output=${i}_count.out ../../slurm_scripts/HTSeq/htseq_${organism}.slurm;
done

for i in $(cat ../accession_list); do
  until [ -f check_${i}.txt ]; do
    sleep 1m
  done
done

rm check*txt

cd ..

################################################################################################################
#FILTERING OUT NON-PROTEIN-CODING GENES BY PARSING THE .GTF FILE
################################################################################################################
mkdir Protein-coding_matrices
cd Protein-coding_matrices

../../curate.sh ${organism} ${feature}

################################################################################################################
#NORMALIZE RAW RNA-SEQ COUNT DATA WITH TPM USING THE PROTEIN-CODING GENE LENGTHS LIST
################################################################################################################
for i in $(cat ../accession_list); do
  ../../TPM.sh ../Protein-coding_matrices/curated_count_${i}_${feature}.txt ${feature};
done
