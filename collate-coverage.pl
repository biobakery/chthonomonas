#! /usr/bin/perl-w;
use strict;
use Data::Dumper;

my %res;

my @strains = qw(P488 TKA WRG T49);

foreach my $s (@strains)
{
my $file = "tmp/$s.cov";
open(FILE, $file) or die "cannot open $file";
while(<FILE>)
	{
	chomp;
	my ($gene, $mean, $sd) = split/\t/, $_;
	$res{$gene}{$s}{'mean'} = $mean;
	$res{$gene}{$s}{'sd'} = $sd;
	}
close(FILE);
}
#print Dumper %res;
print "geneID\tgene\tP488T_median\tP488_sd\tTKA_median\tTKA_sd\tWRG_median\tWRG_sd\tT49_median\tT49_sd\n";
foreach my $key (sort keys %res)
{
print $key, "\t"; 
	foreach my $s (@strains)
	{
	print "$res{$key}{$s}{'mean'}\t$res{$key}{$s}{'sd'}\t";
	}
print "\n";
}