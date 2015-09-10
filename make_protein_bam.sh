#! /usr/bin/sh
#Step 1: Use bowtie2 to align each genome's reads to each genome's genes.

#all gene .fna files downloaded from IMG / all protein coding genes per genome

#first, make indices
bowtie2-build data/TKA_genes.fna TKA
bowtie2-build data/WRG_genes.fna WRG
bowtie2-build data/P488_genes.fna P488
bowtie2-build data/T49_genes.fna T49
bedtools bamtofastq -i TKA.bam -fq TKA.fastq
# in macqiime
process_sff.py -i GIAPFB102.sff
convert_fastaqual_fastq.py -q GIAPFB102.qual -f GIAPFB102.fna -o fastq

#second, do alignments
#P488 genome, P488 proteins
bowtie2 --quiet -q  -x P488 -1 bams/P488_R1.fastq.gz -2  bams/P488_R2.fastq.gz -S P488-proteins.sam
samtools view -bS P488-proteins.sam > P488-proteins.bam
samtools sort P488-proteins.bam P488-P488-proteins-sorted
rm P488-proteins.sam
rm P488-proteins.bam

#P488 genome, T49 proteins
bowtie2 --quiet -q  -x T49 -1 bams/P488_R1.fastq.gz -2  bams/P488_R2.fastq.gz -S P488-proteins.sam
samtools view -bS P488-proteins.sam > P488-proteins.bam
samtools sort P488-proteins.bam P488-T49-proteins-sorted
rm P488-proteins.sam
rm P488-proteins.bam

#P488 genome, TKA proteins
bowtie2 --quiet -q  -x TKA -1 bams/P488_R1.fastq.gz -2  bams/P488_R2.fastq.gz -S P488-proteins.sam
samtools view -bS P488-proteins.sam > P488-proteins.bam
samtools sort P488-proteins.bam P488-TKA-proteins-sorted
rm P488-proteins.sam
rm P488-proteins.bam

#P488 genome, WRG proteins
bowtie2 --quiet -q  -x WRG -1 bams/P488_R1.fastq.gz -2  bams/P488_R2.fastq.gz -S P488-proteins.sam
samtools view -bS P488-proteins.sam > P488-proteins.bam
samtools sort P488-proteins.bam P488-WRG-proteins-sorted
rm P488-proteins.sam
rm P488-proteins.bam

#WRG genome, WRG proteins
bowtie2 --quiet -q  -x WRG -1 bams/WRG_R1.fastq.gz -2  bams/WRG_R2.fastq.gz -S WRG-proteins.sam
samtools view -bS WRG-proteins.sam > WRG-proteins.bam
samtools sort WRG-proteins.bam WRG-WRG-proteins-sorted
rm WRG-proteins.sam
rm WRG-proteins.bam

#WRG genome, P488 proteins
bowtie2 --quiet -q  -x P488 -1 bams/WRG_R1.fastq.gz -2  bams/WRG_R2.fastq.gz -S WRG-proteins.sam
samtools view -bS WRG-proteins.sam > WRG-proteins.bam
samtools sort WRG-proteins.bam WRG-P488-proteins-sorted
rm WRG-proteins.sam
rm WRG-proteins.bam

#WRG genome, T49 proteins
bowtie2 --quiet -q  -x T49 -1 bams/WRG_R1.fastq.gz -2  bams/WRG_R2.fastq.gz -S WRG-proteins.sam
samtools view -bS WRG-proteins.sam > WRG-proteins.bam
samtools sort WRG-proteins.bam WRG-T49-proteins-sorted
rm WRG-proteins.sam
rm WRG-proteins.bam

#WRG genome, TKA proteins
bowtie2 --quiet -q  -x TKA -1 bams/WRG_R1.fastq.gz -2  bams/WRG_R2.fastq.gz -S WRG-proteins.sam
samtools view -bS WRG-proteins.sam > WRG-proteins.bam
samtools sort WRG-proteins.bam WRG-TKA-proteins-sorted
rm WRG-proteins.sam
rm WRG-proteins.bam

#TKA genome, TKA proteins
bowtie2 --quiet -q  -x TKA -U bams/TKA.fastq.gz -S TKA-proteins.sam
samtools view -bS TKA-proteins.sam > TKA-proteins.bam
samtools sort TKA-proteins.bam TKA-TKA-proteins-sorted
rm TKA-proteins.sam
rm TKA-proteins.bam

#TKA genome, T49 proteins
bowtie2 --quiet -q  -x T49 -U bams/TKA.fastq.gz -S TKA-proteins.sam
samtools view -bS TKA-proteins.sam > TKA-proteins.bam
samtools sort TKA-proteins.bam TKA-T49-proteins-sorted
rm TKA-proteins.sam
rm TKA-proteins.bam

#TKA genome, WRG proteins
bowtie2 --quiet -q  -x WRG -U bams/TKA.fastq.gz -S TKA-proteins.sam
samtools view -bS TKA-proteins.sam > TKA-proteins.bam
samtools sort TKA-proteins.bam TKA-WRG-proteins-sorted
rm TKA-proteins.sam
rm TKA-proteins.bam

#TKA genome, P488 proteins
bowtie2 --quiet -q  -x P488 -U bams/TKA.fastq.gz -S TKA-proteins.sam
samtools view -bS TKA-proteins.sam > TKA-proteins.bam
samtools sort TKA-proteins.bam TKA-P488-proteins-sorted
rm TKA-proteins.sam
rm TKA-proteins.bam




