#SET YOUR VARIABLES HERE

#Specify whether the library in question is single-end ('SE') or paired-end ('PE').
library='SE or PE'

#Specify from which organism your data is coming from.  Human='hg38', rat ='Rnor6.0' 
organism='hg38 or Rnor6.0'

#######################################################################################################

#FASTQ-DUMP
for i in $(cat accession_list); do
  qsub -v IN=${i} ../fastq-dump_${library}.pbs &
done

if [ ${library} = 'SE' ]; then
  for i in $(cat ${GEO_list}); do
    until [ -f ${i}.fastq ]; do
      sleep 5
    done
  done
elif [ ${library} = 'PE' ]; then
  for i in $(cat ${GEO_list}); do
    until [ -f ${i}_2.fastq ]; do
      sleep 5
    done
  done
else
  echo 'Please specify whether your library is single-end or paired-end'
  exit
fi

#FASTQC
for i in $(cat accession_list); do
  qsub -v IN=${i} ../fastqc_${library}.pbs &
done

if [ ${library} = 'SE' ]; then
  for i in $(cat ${GEO_list}); do
    until [ -f ${i}_fastqc.html ]; do
      sleep 5
    done
  done
elif [ ${library} = 'PE' ]; then
  for i in $(cat ${GEO_list}); do
    until [ -f ${i}_2_val_2_fastqc.html ]; do
      sleep 5
    done
  done
else
  echo 'Please specify whether your library is single-end or paired-end'
  exit
fi

#TRIMGALORE!
for i in $(cat accession_list); do
  qsub -v IN=${i}  ../trimgalore_${library}.pbs &
done

if [ ${library} = 'SE' ]; then
  for i in $(cat ${GEO_list}); do
    until [ -f ${i}_trimmed_fastqc.html ]; do
      sleep 5
    done
  done
elif [ ${library} = 'PE' ]; then
  for i in $(cat ${GEO_list}); do
    until [ -f ${i}_2_val_2.fq ]; do
      sleep 5
    done
  done
else
  echo 'Please specify whether your library is single-end or paired-end'
  exit
fi

#STAR
for i in $(cat accession_list); do
  qsub -v IN=${i} ../STAR_${organism}_${library}.pbs &
done

for i in $(cat accession_list); do
  until [ -f ${i}Aligned.sortedByCoord.out.bam ]; do
    sleep 5
  done
done

#HTSeq
for i in $(cat accession_list); do
  qsub -v IN=${i} ../htseq_${organism}.pbs &
done
