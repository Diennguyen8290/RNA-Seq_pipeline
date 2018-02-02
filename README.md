# DNM_mRNA-Seq_analysis

Clone this repository to your working directory using

    git clone https://github.com/dmanahan/DNM_mRNA-Seq_analysis.git

and make all scripts executable with

    chmod 775 *

To generate count matrices from raw .sra files:
  Create a sub-directory in which all files from a dataset will be stored (henceforth referred to as the "data directory").
  Download your dataset using downloads.sh
  Edit the variables in RNA-Seq_analysis.sh to reflect the parameters of your data.
    
      nano ../RNA-Seq_analysis.sh
    
  Execute ../RNA-Seq_analysis.sh

IMPORTANT: operate all scripts in this repository FROM your data directories!  All scripts are set with paths relative to your data directory.

To generate PCA plots:
