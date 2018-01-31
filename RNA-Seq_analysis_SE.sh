#Define your varible: Enter the filename used to download your dataset:
GEO_list='<SRA_list>'

#Convert .sra to .fastq
for i in $(cat ${GEO_list}); do
  qsub -v IN=${i} ~/cmb/sra_fastq_conversion_SE.pbs &
done

#Pause pipeline until all .fastq are generated
for i in $(cat ${GEO_list}); do
  until [ -f ${i}.fastq ]; do
    sleep 5
  done
done

#Report your read quality
for i in $(cat ${GEO_list}); do
  qsub -v IN=${i} ~/cmb/fastqc_script_SE.pbs &
done

#Pause pipeline until all reads are QC'd
for i in $(cat ${GEO_list}); do
  until [ -f ${i}_fastqc.html ]; do
    sleep 5
  done
done

#Adapter and quality trim your reads
for i in $(cat ${GEO_list}); do
  qsub -v IN=${i} ~/cmb/trimgalore_SE_script.pbs &
done

#Pause pipeline until all reads are trimmed for quality and adapter content
for i in $(cat ${GEO_list}); do
  until [ -f ${i}_trimmed_fastqc.html ]; do
    sleep 5
  done
done

#Align trimmed reads to your reference genome
for i in $(cat ${GEO_list}); do
  qsub -v IN=${i} ~/cmb/STAR_hg38_SE.pbs &
done

#Pause pipeline until all reads are mapped
for i in $(cat ${GEO_list}); do
  until [ -f ${i}Aligned.sortedByCoord.out.bam ]; do
    sleep 5
  done
done

#Convert read mapping data to raw gene count matrices
for i in $(cat ${GEO_list}); do
  qsub -v IN=${i} ~/cmb/bam_counts.pbs &
done
