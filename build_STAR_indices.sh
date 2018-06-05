sbatch --job-name=build_hg38 --output=STARindex_hg38.out --error=STARindex_hg38.error slurm_scripts/STAR_index/STAR_hg38_index.slurm
sbatch --job-name=build_Rnor6 --output=STARindex_Rnor6.out --error=STARindex_Rnor6.error slurm_scripts/STAR_index/STAR_Rnor6_index.slurm
sbatch --job-name=build_mg38 --output=STARindex_mg38.out --error=STARindex_mg38.error slurm_scripts/STAR_index/STAR_mg38_index.slurm
