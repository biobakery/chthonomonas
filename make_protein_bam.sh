#! /usr/bin/sh

#all gene .fna files downloaded from IMG / all protein coding genes per genome

#first, make indices
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2-build /Users/xochitlmorgan/Dropbox/hutlab/XCM/NZCompGen/TKA_genes.fna TKA
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2-build /Users/xochitlmorgan/Dropbox/hutlab/XCM/NZCompGen/WRG_genes.fna WRG
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2-build /Users/xochitlmorgan/Dropbox/hutlab/XCM/NZCompGen/P488_genes.fna P488
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2-build /Users/xochitlmorgan/Dropbox/hutlab/XCM/NZCompGen/T49_genes.fna T49
#bedtools bamtofastq -i TKA.bam -fq TKA.fastq

#second, do alignments
#P488 genome, P488 proteins
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x P488 -1 /Users/xochitlmorgan/bams/P488_R1.fastq.gz -2  /Users/xochitlmorgan/bams/P488_R2.fastq.gz -S P488-proteins.sam
#samtools view -bS P488-proteins.sam > P488-proteins.bam
#samtools sort P488-proteins.bam P488-P488-proteins-sorted
#rm P488-proteins.sam
#rm P488-proteins.bam

#P488 genome, T49 proteins
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x T49 -1 /Users/xochitlmorgan/bams/P488_R1.fastq.gz -2  /Users/xochitlmorgan/bams/P488_R2.fastq.gz -S P488-proteins.sam
#samtools view -bS P488-proteins.sam > P488-proteins.bam
#samtools sort P488-proteins.bam P488-T49-proteins-sorted
#rm P488-proteins.sam
#rm P488-proteins.bam

#P488 genome, TKA proteins
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x TKA -1 /Users/xochitlmorgan/bams/P488_R1.fastq.gz -2  /Users/xochitlmorgan/bams/P488_R2.fastq.gz -S P488-proteins.sam
#samtools view -bS P488-proteins.sam > P488-proteins.bam
#samtools sort P488-proteins.bam P488-TKA-proteins-sorted
#rm P488-proteins.sam
#rm P488-proteins.bam

#P488 genome, WRG proteins
/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x WRG -1 /Users/xochitlmorgan/bams/P488_R1.fastq.gz -2  /Users/xochitlmorgan/bams/P488_R2.fastq.gz -S P488-proteins.sam
samtools view -bS P488-proteins.sam > P488-proteins.bam
samtools sort P488-proteins.bam P488-WRG-proteins-sorted
rm P488-proteins.sam
rm P488-proteins.bam

#WRG genome, WRG proteins
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x WRG -1 /Users/xochitlmorgan/bams/WRG_R1.fastq.gz -2  /Users/xochitlmorgan/bams/WRG_R2.fastq.gz -S WRG-proteins.sam
#samtools view -bS WRG-proteins.sam > WRG-proteins.bam
#samtools sort WRG-proteins.bam WRG-WRG-proteins-sorted
#rm WRG-proteins.sam
#rm WRG-proteins.bam

#WRG genome, P488 proteins
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x P488 -1 /Users/xochitlmorgan/bams/WRG_R1.fastq.gz -2  /Users/xochitlmorgan/bams/WRG_R2.fastq.gz -S WRG-proteins.sam
#samtools view -bS WRG-proteins.sam > WRG-proteins.bam
#samtools sort WRG-proteins.bam WRG-P488-proteins-sorted
#rm WRG-proteins.sam
#rm WRG-proteins.bam

#WRG genome, T49 proteins
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x T49 -1 /Users/xochitlmorgan/bams/WRG_R1.fastq.gz -2  /Users/xochitlmorgan/bams/WRG_R2.fastq.gz -S WRG-proteins.sam
#samtools view -bS WRG-proteins.sam > WRG-proteins.bam
#samtools sort WRG-proteins.bam WRG-T49-proteins-sorted
#rm WRG-proteins.sam
#rm WRG-proteins.bam

#WRG genome, TKA proteins
/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x TKA -1 /Users/xochitlmorgan/bams/WRG_R1.fastq.gz -2  /Users/xochitlmorgan/bams/WRG_R2.fastq.gz -S WRG-proteins.sam
samtools view -bS WRG-proteins.sam > WRG-proteins.bam
samtools sort WRG-proteins.bam WRG-TKA-proteins-sorted
rm WRG-proteins.sam
rm WRG-proteins.bam

#TKA genome, TKA proteins
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x TKA -U /Users/xochitlmorgan/bams/TKA.fastq.gz -S TKA-proteins.sam
#samtools view -bS TKA-proteins.sam > TKA-proteins.bam
#samtools sort TKA-proteins.bam TKA-TKA-proteins-sorted
#rm TKA-proteins.sam
#rm TKA-proteins.bam

#TKA genome, T49 proteins
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x T49 -U /Users/xochitlmorgan/bams/TKA.fastq.gz -S TKA-proteins.sam
#samtools view -bS TKA-proteins.sam > TKA-proteins.bam
#samtools sort TKA-proteins.bam TKA-T49-proteins-sorted
#rm TKA-proteins.sam
#rm TKA-proteins.bam

#TKA genome, WRG proteins
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x WRG -U /Users/xochitlmorgan/bams/TKA.fastq.gz -S TKA-proteins.sam
#samtools view -bS TKA-proteins.sam > TKA-proteins.bam
#samtools sort TKA-proteins.bam TKA-WRG-proteins-sorted
#rm TKA-proteins.sam
#rm TKA-proteins.bam

#TKA genome, P488 proteins
#/Users/xochitlmorgan/Downloads/bowtie2-2.2.1/bowtie2 --quiet -q  -x P488 -U /Users/xochitlmorgan/bams/TKA.fastq.gz -S TKA-proteins.sam
#samtools view -bS TKA-proteins.sam > TKA-proteins.bam
#samtools sort TKA-proteins.bam TKA-P488-proteins-sorted
#rm TKA-proteins.sam
#rm TKA-proteins.bam




