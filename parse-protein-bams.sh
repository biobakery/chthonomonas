#! /usr/bin/sh

# coverage of all P488 genes  in P488 genome
bedtools genomecov -d -i bams/P488.proteins.bed -ibam bams/P488-P488-proteins-sorted.bam > P488.P488.tmp
perl parse_coverage.pl P488.P488.tmp > P488.cov

#get coverage at each position for all T49 proteins in P488 genome
bedtools genomecov -d -i bams/T49.proteins.bed -ibam bams/P488-T49-proteins-sorted.bam > P488.T49.tmp
perl parse_coverage.pl P488.T49.tmp >>P488.cov

#get coverage at each position for all WRG proteins in P488 genome
bedtools genomecov -d -i bams/WRG.proteins.bed -ibam bams/P488-WRG-proteins-sorted.bam > P488.WRG.tmp
perl parse_coverage.pl P488.WRG.tmp >>P488.cov

#get coverage at each position for all TKA proteins in P488 genome
bedtools genomecov -d -i bams/TKA.proteins.bed -ibam bams/P488-TKA-proteins-sorted.bam > P488.TKA.tmp
perl parse_coverage.pl P488.TKA.tmp >>P488.cov

# coverage of all TKA genes  in TKA genome
bedtools genomecov -d -i bams/TKA.proteins.bed -ibam bams/TKA-TKA-proteins-sorted.bam > TKA.TKA.tmp
perl parse_coverage.pl TKA.TKA.tmp > TKA.cov

# coverage  in each position for all T49 proteins in TKA genome 
bedtools genomecov -d -i bams/T49.proteins.bed -ibam bams/TKA-T49-proteins-sorted.bam > TKA.T49.tmp
perl parse_coverage.pl TKA.T49.tmp >> TKA.cov

# coverage  in each position for all P488 proteins in TKA genome 
bedtools genomecov -d -i bams/P488.proteins.bed -ibam bams/TKA-P488-proteins-sorted.bam > TKA.P488.tmp
perl parse_coverage.pl TKA.P488.tmp >> TKA.cov

# coverage  in each position for all WRG proteins in TKA genome 
bedtools genomecov -d -i bams/WRG.proteins.bed -ibam bams/TKA-WRG-proteins-sorted.bam > TKA.WRG.tmp
perl parse_coverage.pl TKA.WRG.tmp >> TKA.cov

# coverage of all WRG genes  in WRG genome
bedtools genomecov -d -i bams/WRG.proteins.bed -ibam bams/WRG-WRG-proteins-sorted.bam > WRG.WRG.tmp
perl parse_coverage.pl WRG.WRG.tmp > WRG.cov

# coverage  in each position for all T49 proteins in WRG genome 
bedtools genomecov -d -i bams/T49.proteins.bed -ibam bams/WRG-T49-proteins-sorted.bam > WRG.T49.tmp
perl parse_coverage.pl WRG.T49.tmp >> WRG.cov

# coverage  in each position for all P488 proteins in WRG genome 
bedtools genomecov -d -i bams/P488.proteins.bed -ibam bams/WRG-P488-proteins-sorted.bam > WRG.P488.tmp
perl parse_coverage.pl WRG.P488.tmp >> WRG.cov

# coverage  in each position for all TKA proteins in WRG genome 
bedtools genomecov -d -i bams/TKA.proteins.bed -ibam bams/WRG-TKA-proteins-sorted.bam > WRG.TKA.tmp
perl parse_coverage.pl WRG.TKA.tmp >> WRG.cov

mv *.cov tmp
mv *.tmp tmp




