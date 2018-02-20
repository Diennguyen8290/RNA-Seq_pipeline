#Define your variables
path_to_gtf='gencode.v27.annotation.gtf'

#Please select which protein-coding feature you want to serve as your reference.  'CDS', 'gene', or 'transcript'.
coding_feature='transcript'

################################################################################################################

#From the .gtf file, create a text file with ONLY protein coding genes.
cat ${path_to_gtf} | grep 'protein' > output0.txt

if [ ${coding_feature} = 'CDS' ]; then
  #Extract CDS region information ONLY
  cat output0.txt | grep 'CDS' > output1.txt
  sed -i '/CCDS/d' output1.txt
elif [ ${coding_feature} = 'gene' ]; then
  #Extract gene information ONLY
  sed '/transcript/d' output0.txt > output1.txt
elif [ ${coding_feature} = 'transcript' ]; then
  #Extract transcript information ONLY
  cat output0.txt | grep 'transcript' > output1.txt
  sed -i '/exon/d' output1.txt
else
  echo 'Please specify whether you want genes, transcripts, or CDS regions to serve as your reference.'
fi

#Extract the ENSEMBL gene name and gene length from .txt.  NOTE that transcripts will be assigned to same gene name and will appear as duplicates.
awk '{print $10 "\t" ($5 - $4)}' output1.txt > output2.txt

#Remove all quotes from our protein coding gene list.
sed -i 's/\"//g' output2.txt

#Remove all semicolons from our ptoein coding gene list.
sed -i 's/;//g' output2.txt

#Remove all decimals from our protein coding gene list.  Decimals indicate splicing variants.
sed -i 's/\.[0-9]*//' output2.txt

#Combine duplicate ENSEMBL IDs and average their gene length
awk '
    NR>1{
        arr[$1]   += $2
        count[$1] += 1
    }
    END{
        for (a in arr) {
            print a " " arr[a] / count[a]
        }
    }
' output2.txt > output3.txt

#Sort the protein coding ENSEMBL IDs and gene lengths alphabetically by ENSEMBL ID.
sort output3.txt > coding_gene_lengths_${coding_feature}.txt
sed -i '/__/d' coding_gene_lengths_${coding_feature}.txt
awk '{$2=""; print $0}' coding_gene_lengths_${coding_feature}.txt > coding_genes_${coding_feature}.txt
