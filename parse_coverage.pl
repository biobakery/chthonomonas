#! /usr/bin/perl-w;
use strict;
use Data::Dumper;
use Math::NumberCruncher;

my ($file) = @ARGV;

my %dat;
open(FILE, $file) or die "cannot open $file";

while(<FILE>)
{
chomp;
my ($id, $pos, $dep) = split(/\t/, $_);
push(@{$dat{$id}}, $dep);
}

foreach my $key (sort keys %dat)
{
print $key, "\t";
my $median = Math::NumberCruncher::Median($dat{$key});
my $sd = Math::NumberCruncher::StandardDeviation($dat{$key});
print "$median\t$sd\n";
}

