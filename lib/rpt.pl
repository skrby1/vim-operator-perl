#!/usr/bin/perl -w
use strict;

srand();

my $rpt = $ARGV[0] ? $ARGV[0] : 1;
$rpt = "int(rand($rpt)) + 1" if($ARGV[1]);

my $out = "";
while(<STDIN>){
  my $temp;
  if(chomp()){
    ($temp = $_) =~ s/(.)/$1 x (eval $rpt)/ge;
    $out .= $temp. "\n";
  } else {
    ($temp = $_) =~ s/(.)/$1 x (eval $rpt)/ge;
    $out .= $temp;
  }
}

chomp($out);
print "$out";
