#! /usr/bin/sh

[ -z $BASH ] || shopt -s expand_aliases
alias BEGINCOMMENT="if [ ]; then"
alias ENDCOMMENT="fi"

#Step 1: Use bowtie2 to align each genome's reads to each genome's genes.

#all gene .fna files downloaded from IMG / all protein coding genes per genome

#first, make indices
bowtie2-build data/TKA_genes.fna bams/TKA
bowtie2-build data/WRG_genes.fna bams/WRG
bowtie2-build data/P488_genes.fna bams/P488
bowtie2-build data/T49_genes.fna bams/T49
#bedtools bamtofastq -i TKA.bam -fq TKA.fastq
# in macqiime
#process_sff.py -i GIAPFB102.sff
#convert_fastaqual_fastq.py -q GIAPFB102.qual -f GIAPFB102.fna -o fastq



#second, do alignments
#P488 genome, P488 proteins
bowtie2 --quiet -q  -x bams/P488 -1 bams/P488_R1.fastq.gz -2  bams/P488_R2.fastq.gz -S P488-proteins.sam
samtools view -bS P488-proteins.sam > P488-proteins.bam
samtools sort P488-proteins.bam -o P488-P488-proteins-sorted.bam
rm P488-proteins.sam
rm P488-proteins.bam

#P488 genome, T49 proteins
bowtie2 --quiet -q  -x bams/T49 -1 bams/P488_R1.fastq.gz -2  bams/P488_R2.fastq.gz -S P488-proteins.sam
samtools view -bS P488-proteins.sam > P488-proteins.bam
samtools sort P488-proteins.bam-o P488-T49-proteins-sorted.bam
rm P488-proteins.sam
rm P488-proteins.bam

#P488 genome, TKA proteins
bowtie2 --quiet -q  -x bams/TKA -1 bams/P488_R1.fastq.gz -2  bams/P488_R2.fastq.gz -S P488-proteins.sam
samtools view -bS P488-proteins.sam > P488-proteins.bam
samtools sort P488-proteins.bam -o P488-TKA-proteins-sorted.bam
rm P488-proteins.sam
rm P488-proteins.bam

#P488 genome, WRG proteins
bowtie2 --quiet -q  -x bams/WRG -1 bams/P488_R1.fastq.gz -2  bams/P488_R2.fastq.gz -S P488-proteins.sam
samtools view -bS P488-proteins.sam > P488-proteins.bam
samtools sort P488-proteins.bam -o P488-WRG-proteins-sorted.bam
rm P488-proteins.sam
rm P488-proteins.bam

#WRG genome, WRG proteins
bowtie2 --quiet -q  -x bams/WRG -1 bams/WRG_R1.fastq.gz -2  bams/WRG_R2.fastq.gz -S WRG-proteins.sam
samtools view -bS WRG-proteins.sam > WRG-proteins.bam
samtools sort WRG-proteins.bam -o WRG-WRG-proteins-sorted.bam
rm WRG-proteins.sam
rm WRG-proteins.bam

#WRG genome, P488 proteins
bowtie2 --quiet -q  -x bams/P488 -1 bams/WRG_R1.fastq.gz -2  bams/WRG_R2.fastq.gz -S WRG-proteins.sam
samtools view -bS WRG-proteins.sam > WRG-proteins.bam
samtools sort WRG-proteins.bam -o WRG-P488-proteins-sorted.bam
rm WRG-proteins.sam
rm WRG-proteins.bam

#WRG genome, T49 proteins
bowtie2 --quiet -q  -x bams/T49 -1 bams/WRG_R1.fastq.gz -2  bams/WRG_R2.fastq.gz -S WRG-proteins.sam
samtools view -bS WRG-proteins.sam > WRG-proteins.bam
samtools sort WRG-proteins.bam -o WRG-T49-proteins-sorted.bam
rm WRG-proteins.sam
rm WRG-proteins.bam

#WRG genome, TKA proteins
bowtie2 --quiet -q  -x bams/TKA -1 bams/WRG_R1.fastq.gz -2  bams/WRG_R2.fastq.gz -S WRG-proteins.sam
samtools view -bS WRG-proteins.sam > WRG-proteins.bam
samtools sort WRG-proteins.bam -o WRG-TKA-proteins-sorted.bam
rm WRG-proteins.sam
rm WRG-proteins.bam

#TKA genome, TKA proteins
bowtie2 --quiet -q  -x bams/TKA -U bams/TKA.fastq.gz -S TKA-proteins.sam
samtools view -bS TKA-proteins.sam > TKA-proteins.bam
samtools sort TKA-proteins.bam -o TKA-TKA-proteins-sorted.bam
rm TKA-proteins.sam
rm TKA-proteins.bam

#TKA genome, T49 proteins
bowtie2 --quiet -q  -x bams/T49 -U bams/TKA.fastq.gz -S TKA-proteins.sam
samtools view -bS TKA-proteins.sam > TKA-proteins.bam
samtools sort TKA-proteins.bam -o TKA-T49-proteins-sorted.bam
rm TKA-proteins.sam
rm TKA-proteins.bam

#TKA genome, WRG proteins
bowtie2 --quiet -q  -x bams/WRG -U bams/TKA.fastq.gz -S TKA-proteins.sam
samtools view -bS TKA-proteins.sam > TKA-proteins.bam
samtools sort TKA-proteins.bam -o TKA-WRG-proteins-sorted.bam
rm TKA-proteins.sam
rm TKA-proteins.bam

#TKA genome, P488 proteins
bowtie2 --quiet -q  -x bams/P488 -U bams/TKA.fastq.gz -S TKA-proteins.sam
samtools view -bS TKA-proteins.sam > TKA-proteins.bam
samtools sort TKA-proteins.bam -o TKA-P488-proteins-sorted.bam
rm TKA-proteins.sam
rm TKA-proteins.bam

#T49 genome, T49 proteins
bowtie2 --quiet -q  -x bams/T49 -U bams/T49.fastq -S T49-proteins.sam
samtools view -bS T49-proteins.sam > T49-proteins.bam
samtools sort T49-proteins.bam -o T49-T49-proteins-sorted.bam
rm T49-proteins.sam
rm T49-proteins.bam

#T49 genome, P488 proteins
bowtie2 --quiet -q  -x bams/P488 -U bams/T49.fastq -S T49-proteins.sam
samtools view -bS T49-proteins.sam > T49-proteins.bam
samtools sort T49-proteins.bam -o T49-P488-proteins-sorted.bam
rm T49-proteins.sam
rm T49-proteins.bam

#T49 genome, TKA proteins
bowtie2 --quiet -q  -x bams/TKA -U bams/T49.fastq -S T49-proteins.sam
samtools view -bS T49-proteins.sam > T49-proteins.bam
samtools sort T49-proteins.bam -o T49-TKA-proteins-sorted.bam
rm T49-proteins.sam
rm T49-proteins.bam

#T49 genome, WRG proteins
bowtie2 --quiet -q  -x bams/WRG -U bams/T49.fastq -S T49-proteins.sam
samtools view -bS T49-proteins.sam > T49-proteins.bam
samtools sort T49-proteins.bam -o T49-WRG-proteins-sorted.bam
rm T49-proteins.sam
rm T49-proteins.bam




