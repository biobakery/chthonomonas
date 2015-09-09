#! /usr/bin/perl-w;
use strict;
use Data::Dumper;


my %key;
my $keep;
my $strand;

my @genomes = ("T49", "WRG", "TKA", "P488");

foreach my $g (@genomes)
{
open(LOG, ">$g.proteins.bed") or die "cannot open log";
my $string = ();
my $keep = ();
my $file = $g."_genes.fna";
	open(FILE, "/Users/xochitlmorgan/Dropbox/hutlab/XCM/NZCompGen/$file") or die "cannot open";
	while(<FILE>)
	{
		chomp;
		if (/>/)
			{
			if ($keep ne undef) { print LOG "$keep\t1\t", length($string), "\t254\t$strand\n"; } 
			$string = ();
			if ($_=~/\+/) { $strand eq "+"; }
			else { $strand eq "-" ;}
			my @l = split/\s/, $_;
			my $id = shift(@l);
			$id=~s/>//g;
			$keep = $id;
			}
			else
			{
			$string = $string.$_;
			}
		
	}
	close(FILE);
	close(LOG);
}

