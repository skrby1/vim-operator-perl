#!/usr/bin/perl -w

#rpt.pl 指定したテキストの１文字を指定した回数分繰り返す。
#ARGVの２つ目に0以外の値を与えると、指定した回数分までのランダム個文字を繰り返す

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
