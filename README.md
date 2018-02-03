# RNA-Seq analysis

While logged onto hpc-cmb.usc.edu,

clone this repository to your working directory using

    git clone https://github.com/dmanahan/DNM_mRNA-Seq_analysis.git

and make all scripts executable with

    chmod 775 *

For each of your datasets, create a sub-directory (hence forth referred to here as a "data directory") within your working directory
    
    mkdir data

Important!  All scripts in this repository are set with paths relative to your data directories.  You must operate all scripts FROM your data directories!

    cd data
  
##############################################################################################

To generate count matrices from raw .sra files:
  
  Download your dataset from GEO.  See Downloading_GEO_datasets.pdf in this repository.
  
    ../downloads.sh
  
  Edit the variables in RNA-Seq_analysis.sh to reflect the parameters of your data.  i.e., whether the sequenced reads are single-end or paired-end ('SE' and 'PE', respectively) and whether the data came from human or rat cells ('hg38' and 'Rnor6.0', respectively).
    
    nano ../RNA-Seq_analysis.sh
    
  Execute the RNA-Seq pipeline
      
    ../RNA-Seq_analysis.sh

##############################################################################################

To generate PCA plots:
