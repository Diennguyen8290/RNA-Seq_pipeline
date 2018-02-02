for i in $(cat FILENAME); do x=$(echo ${i} | cut -c1-6); wget ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/${x}/${i}/$i.sra; done
