#Must be executed in a node with network connection, such as hpc-transfer.usc.edu

mkdir genome_references
cd genome_references

#Download human genome fasta (sequence) and .gtf (annotation) files from GENCODE. 
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_27/GRCh38.primary_assembly.genome.fa.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_27/gencode.v27.annotation.gtf.gz

#Download rat genome fasta (sequence) and .gtf (annotation) files from NCBI/ENSEMBL (Both databases are identical to each other)
wget ftp://ftp.ensembl.org/pub/release-91/fasta/rattus_norvegicus/dna/Rattus_norvegicus.Rnor_6.0.dna.toplevel.fa.gz
wget ftp://ftp.ensembl.org/pub/release-91/gtf/rattus_norvegicus/Rattus_norvegicus.Rnor_6.0.91.chr.gtf.gz

#Downlaod mouse genome fasta (sequence) and .gtf (annotation) files from GENCODE.
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M16/GRCm38.primary_assembly.genome.fa.gz
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M16/gencode.vM16.annotation.gtf.gz

#Unzip all compressed fasta and .gtf files.
gunzip -vf *gz

mv GCF_000001895.5_Rnor_6.0_genomic.fna GCF_000001895.5_Rnor_6.0_genomic.fa

cd ..


