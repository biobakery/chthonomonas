#! /usr/bin/perl-w;
use strict;
use Data::Dumper;

my %res;

my @strains = qw(P488 TKA WRG);

foreach my $s (@strains)
{
my $file = "/Users/xochitlmorgan/bams/$s.cov";
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
print "gene\tP488T_mean\tP488_sd\tTKA_mean\tTKA_sd\tWRG_mean\tWRG_sd\n";
foreach my $key (sort keys %res)
{
print $key, "\t"; 
	foreach my $s (@strains)
	{
	print "$res{$key}{$s}{'mean'}\t$res{$key}{$s}{'sd'}\t";
	}
print "\n";
}