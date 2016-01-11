#! /usr/bin/perl-w;
use strict;
use Data::Dumper;

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
print "$l[0]\t$l[1]\t";
if ($l[0] =~/T49/)
		{
		$l[5] = 1;
		#print "$l[0] so $l[5] is 1\n";
		}
my @slice = ($l[2], $l[3], $l[4], $l[5]);
#T49-native genes must be counted as 'present' in T49 regardless of T49 coverage, since T49 coverage is not reliable.

foreach my $s (@slice)
	{
	#for everything non-T49 not-undefined means 'has already passed min filter' => (25th percentile - 2 IQR for TKA, WRG, and 
	#P488 reads / presence of TKA, WRG, and P488 genes in T49 genome is a threshold of > 1 median coverage. 	
	if ($s ne undef) 
		{
		$s =1;
		++$hicov;
		}
	else
		{
		$s = 0;
		}	
	print $s, "\t";	
	}
my $g = shift(@l);
#print $_, "$hicov\t";
print "$hicov\t";	
	#print "$key{$k}\t";
	my ($q, $r) = split/\./, $g;
	my $a = $uc->{$r};
	if ($a eq undef)
		{
		my $c = $alias->{$r};
		$a = $uc->{$c};
		}
	my $count = scalar(@$a);
	print $count, "\t";	
	foreach my $b (@$a)
		{
		print "$key{$b},";
		}
	print "\n";
}

=pod
foreach my $k (keys %{$uc})
{
my $count = 0;
#print "$key{$k}\t";
	my $a = $uc->{$k};
	foreach my $b (@$a)
		{
		print "$key{$b}\t";
		++$count;
		}
print "$count\n";
}