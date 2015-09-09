README

This is the software pipeline written by Xochitl Morgan (morganx@gmail.com) to calculate
coverage of genes within strains for Chthonomonas calidirosea. It performs the following steps:

1. make_protein_bam.sh 
This shell script creates bowtie2 indices for each strain, then  uses bowtie2 to align reads 
for each strain, in each genome. The inputs are nucleotide fasta files for genes,
and fastq files for reads.

The fastq files are not included in the bitbucket repository, but are available
for download at **insert URL**

How to run:

sh make_protein_bam.sh


2. feature_bed.pl

This perl script generates a bed file for each strain,  in which the features are the 
strain's genes. The inputs are the nucleotide fasta files for the strain, and the
outputs are a bed file for each strain. 

How to run: 

perl feature_bed.pl

3. parse-protein-bams.sh
This step compiles the per-position coverage for each gene, then pipes the output through
the parse_coverage script, which calculates the median and standard deviation per gene. 
The inputs are the bam files created in step 1, and bed files created in step 2. The outputs
 are one file per genome (strain.cov), summarizing the per-gene median and standard deviation coverage.
 
 How to run:
 
 sh parse-protein-bams.sh

4. collate_coverage.pl
This reformats the four output files produced in step 3 into an Excel-friendly table.

How to run:

perl collate_coverage.pl > table

5. index.pl
This attaches a strain label to each gene identifier the table produced in step 4, so
it is easier to tell which gene belongs to which strain. 

How to run:

perl index.pl table > final

Prerequisites:

Bowtie2, bedtools, perl Math::NumberCruncher