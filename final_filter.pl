#! /usr/bin/perl-w;
use strict;
use Data::Dumper;
#final: quantile(as.numeric(col$numericdat[,1]), na.rm=TRUE, probs=0.25) - (2 * IQR(as.numeric(col$numericdat[,1]), na.rm=TRUE))
# All other strains are based on higher-throughput Ion Torrent or Illumina data and correspond to 2 IQR-based cutoff.
# note: this is based on low-coverage 454 data and corresponds to 4th to 5th percentile coverage.
my %vals = (
"T49" =>1, 			
"WRG" => 17,
"TKA" =>12,
"P488"=> 35
);

my %annot;
get_annots();
#print Dumper %annot;
#print Dumper %vals;
print "gene\tannot\tP488\tTKA\tWRG\tT49\n";
while(<>)
{
chomp;
my @l = split/\t/, $_;
shift(@l);
my ($gene, $p488, $tka, $wrg, $t49) = ($l[0], $l[2], $l[4], $l[6], $l[8]);
my ($a, $b) = split(/\./, $gene);
#print "$gene, $p488, $tka, $wrg, $t49, I see $a and $b for $gene\n";
if ($a eq 'P488')
	{
	if ($p488 < $vals{"P488"}) { next};	
	if ($p488 >= $vals{"P488"}) { do_stuff(@l); next;}
	}
if ($a eq 'TKA')
	{
	if ($tka < $vals{"TKA"}) { next};	
	if ($tka >= $vals{"TKA"}) { do_stuff( @l); next;}
	}
if ($a eq 'WRG')
	{
	if ($wrg < $vals{"WRG"}) { next};	
	if ($wrg >= $vals{"WRG"}) { do_stuff(@l); next;}
	}	
if ($a eq 'T49')
	{
	#if ($t49 < $vals{"T49"}) {  next};	
	#if ($t49 >= $vals{"T49"}) { do_stuff(@l); }
	# T49 genes will not be filtered out due to low coverage because 454 sequencing
	# is not deep enough to do it without filtering out too many genes. We
	# therefore do not filter out any T49-native genes due to low coverage.
	do_stuff(@l);
	}
}

sub do_stuff
{
my @l = @_;
my ($gene, $p488, $tka, $wrg, $t49) = ($l[0], $l[2], $l[4], $l[6], $l[8]);
my ($a, $b) = split(/\./, $gene);
print "$gene\t$annot{$b}\t";
	if ($p488 >= $vals{"P488"}) { print "$l[2]\t";} else {print "\t"; }	
	if ($tka >= $vals{"TKA"}) { print "$l[4]\t";} else {print "\t"; }
	if ($wrg >= $vals{"WRG"}) { print "$l[6]\t";} else {print "\t"; }
	#T49-native genes can't be filtered out due to low coverage, but in other genomes, 
	#coverage must be at least 1.
	if ($t49 >= $vals{"T49"} or ($a eq 'T49' )) { print "$l[8]\t";} else {print "\t"; }			
	print "\n";
}

sub get_annots
{
open(FILE, "data/genes.txt") or die "cannot open data/genes.txt";
while(<FILE>)
	{
	chomp;
	my ($a, $b) = split/\t/, $_;
	$annot{$a} = $b;
	}
close(FILE);
}