#!/bin/sh

suffix='S288c_DSB_LY_Capture_artificial_v12_parasplit_borderless_q20_v324_PCRfree' #suffix that complement the initial sample name
cooldir='/mnt/e/cool/'
inputdir='./Inputs/' #location of other input files required to run ssHiCstuff. Provided for the genome S288c_DSB_LY_Capture_artificial_v12
outputdir='/mnt/e/ssHiC_output/'

SAMP=("AD572" "AD576")

for sample in "${SAMP[@]}" ; do
  name=$sample'_'$suffix
  mkdir $outputdir$name;
  echo $name "starting"

  #Run the fill sshicstuff pipeline
  sshicstuff pipeline -m $cooldir$name'.cool' -c $inputdir'capture_oligo_positions_v12.csv' -C $inputdir'S288c_chr_centro_coordinates_S288c_DSB_LY_Capture_artificial_v12.tsv' -a $inputdir'additional_probe_groups.tsv' -b 1000 2000 5000 10000 -N -F -n 2 -E "chr2" "chr3" "2_micron" "mitochondrion" "chr_artificial_dsDNA" "chr_artificial_ssDNA" "chr5" --bin-cen 10000 --bin-telo 1000 --window-cen 150000 --window-telo 15000 -o $outputdir$name --copy-inputs --balanced-stats

  echo $name "is done"
done
