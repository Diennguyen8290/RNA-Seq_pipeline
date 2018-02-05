mkdir RSEM_hg38_reference
cd RSEM_hg38_reference
rsem-prepare-reference --gtf ../gencode.v27.annotation.gtf --star ../GRCh38.p10.genome.fa .
cd ..
