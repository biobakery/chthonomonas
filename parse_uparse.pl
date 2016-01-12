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

print "locusID\tannotation\tpresentP488\tpresentTKA\tpresentWRG\tpresentT49\ttotalStrainsPresent\tUparseClusterSize\tUparseCluster\n";
my %key;


my @p488 = `cut -f 1 bams/P488.proteins.bed`;
my @tka = `cut -f 1 bams/TKA.proteins.bed`;
my @wrg = `cut -f 1 bams/WRG.proteins.bed`;
my @t49 = `cut -f 1 bams/T49.proteins.bed`;

foreach my $p (@p488)
{
chomp($p);
$key{$p} = "P488.$p";
}

foreach my $p (@t49)
{
chomp($p);
$key{$p} = "T49.$p";
}

foreach my $p (@tka)
{
chomp($p);
$key{$p} = "TKA.$p";
}

foreach my $p (@wrg)
{
chomp($p);
$key{$p} = "WRG.$p";
}

my $uc;
my $alias;
open(FILE, "data/results95.uc.sorted") or die "cannot open uclust log";
while(<FILE>)
{
chomp;
my @l = split/\t/, $_;
my ($mem, $seed) = ($l[8], $l[9]);
if ($l[0] eq "C")
	{
	push(@{$uc->{$mem}}, $mem);
	}
if ($l[0] eq "H")
	{
	push(@{$uc->{$seed}}, $mem);
	$alias->{$mem} = $seed;
	}	
}
close(FILE);
#print Dumper $uc;

#open(FILE, "last-table.txt") or die "cannot open last-table.txt";
while(<>)
{
	chomp;
	my $hicov;
	my @l = split/\t/, $_; 
my ($gene, $p488, $tka, $wrg, $t49) = ($l[0], $l[2], $l[4], $l[6], $l[8]);
	my ($a, $b) = split(/\./, $gene);
	if ($gene =~/T49/)
		{
		$l[8] = 1;
		#T49-native genes must be counted as 'present' in T49 regardless of T49 coverage, since T49 coverage is not reliable.
		#print "$l[0] so $l[5] is 1\n";
		}
		
	if ($a eq 'P488')
	{
		if ($p488 < $vals{"P488"}) { next}; # filter out	
		if ($p488 >= $vals{"P488"}) { do_stuff(@l); next;}
	}
	if ($a eq 'TKA')
	{
		if ($tka < $vals{"TKA"}) { next}; # filter out	
		if ($tka >= $vals{"TKA"}) { do_stuff( @l); next;}
	}
	if ($a eq 'WRG')
	{
		if ($wrg < $vals{"WRG"}) { next};	# filter out
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

sub do_stuff
{
my $hicov = 0;
my @l = @_;
my ($gene, $p488, $tka, $wrg, $t49) = ($l[0], $l[2], $l[4], $l[6], $l[8]);
my ($a, $b) = split(/\./, $gene);
print $gene, "\t";
	if ($p488 >= $vals{"P488"}) { print "1\t"; ++$hicov;} else {print "\t"; }	
	if ($tka >= $vals{"TKA"}) { print "1\t";++$hicov;} else {print "\t"; }
	if ($wrg >= $vals{"WRG"}) { print "1\t";++$hicov;} else {print "\t"; }
	#T49-native genes can't be filtered out due to low coverage, but in other genomes, 
	#coverage must be at least 1.
	if ($t49 >= $vals{"T49"} or ($a eq 'T49' )) { print "1\t";++$hicov;} else {print "\t"; }			
	print "$hicov\t";
	my $q = $uc->{$b};
	if ($q eq undef)
		{
		my $r = $alias->{$b};
		$q = $uc->{$r};
		}
	my $count = scalar(@$q);
	print $count, "\t";	
	foreach my $f (@$q)
		{
		print "$key{$f},";
		}
		print "$gene\t$annot{$b}\t";
		
	print "\n";
}

