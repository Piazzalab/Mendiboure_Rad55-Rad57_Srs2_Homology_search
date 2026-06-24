#!/bin/sh

### activate Conda_env_ChIP_processing beforehand
### the fastq files should be names like "JS47_R1.fq.gz" 

threads=6
#provide paired IP and input samples
IPs=("JS43" "JS49")
INs=("JS46" "JS52")
genome="S288c_DSB_LY_Capture_N"                 #name of the reference S. cerevisiae genome
spikein="GCF_000002545.3_ASM254v2_genomic"      #name of the reference genome used for the calibrator (C. glabrata)

for ((i = 0; i < ${#IPs[@]}; i++)); do
    
    IP="${IPs[$i]}"
    IN="${INs[$i]}"
    fastqdir='/mnt/e/Science/Reads/'        #directory where paired end reads in the form _R1.fq.gz and _R2.fq.gz are located
    sampleIP="/mnt/e/Science/Reads/"$IP
    sampleIN="/mnt/e/Science/Reads/"$IN
    output=$IP'_'$genome'_calibrated'
    outputdir='/mnt/e/ChIP/'$output
    genomedir="/mnt/e/Genomes/"             #location of the cerevisiae and glabrata reference genomes. Each reference must be in a folder with a name identical to that of the fasta and index files (eg .../cerevisiae_ref/cerevisiae_ref.fa)

    dir=$IP
    
    mkdir $dir
    mkdir $outputdir
    echo $dir
    echo $outputdir
 
    # Perform alignement of the paired IP and Input samples on both the cerevisiae and glabrata genomes
    ~/bin/tinyMapper/tinyMapper.sh --mode ChIP --sample $sampleIP --genome $genomedir$genome'/'$genome --input $sampleIN --calibration $genomedir$spikein'/'$spikein --output $dir --threads $threads --keepIntermediate

    cp -R $dir'/logs' $dir'/peaks' $dir'/stats' $dir'/tracks' $outputdir
    mv -v $dir/ $outputdir/
    
   
done





