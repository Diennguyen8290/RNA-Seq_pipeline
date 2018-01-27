GEO_list='cat <GEO_list>'

for i in $(${GEO_list}); do
  qsub -v IN=${i} ~/cmb/sra_fastq_conversion_SE.pbs &
done

for i in $(${GEO_list}); do
  until [ -f ${i}.fastq ]; do
    sleep 5
  done
done

for i in $(${GEO_list}); do
  qsub -v IN=${i} ~/cmb/fastqc_script_SE.pbs &
done

for i in $(${GEO_list}); do
  until [ -f ${i}_fastqc.html ]; do
    sleep 5
  done
done

for i in $(${GEO_list}); do
  qsub -v IN=${i} ~/cmb/trimgalore_SE_script.pbs &
done

for i in $(${GEO_list}); do
  until [ -f ${i}_trimmed_fastqc.html ]; do
    sleep 5
  done
done

for i in $(${GEO_list}); do
  qsub -v IN=${i} ~/cmb/STAR_hg38_SE.pbs &
done

for i in $(${GEO_list}); do
  until [ -f ${i}Aligned.sortedByCoord.out.bam ]; do
    sleep 5
  done
done

for i in $(${GEO_list}); do
  qsub -v IN=${i} ~/cmb/bam_counts.pbs &
done
