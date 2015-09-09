#! /usr/bin/perl-w;
use strict;
use Data::Dumper;

my %key;

my @p488 = `cut -f 1 P488.proteins.bed`;
my @tka = `cut -f 1 TKA.proteins.bed`;
my @wrg = `cut -f 1 WRG.proteins.bed`;
my @t49 = `cut -f 1 T49.proteins.bed`;

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

#print Dumper %key;
while(<>)
{
my @l = split/\t/, $_;

my $id =  $key{$l[0]};
print $id, "\t";


foreach my $l (@l)
	{
	print $l, "\t";
	}

}