#!/usr/bin/perl -w
use strict;

my $in;
{
  local $/;
  $in = <STDIN>;
}
my $out;
($out = $in) =~ s/print/\$out =/g;
my $chk = eval $out;

if($chk){
  if($ARGV[0]){
    if ($ARGV[0] > 0) {
      my $n = "";
      $n = "\n" if $in !~ /\n\Z/;
      if ($ARGV[0] == 1) {
        $out = $in. $out;
      } elsif ($ARGV[0] == 2) {
        $out = $in . $n. $out;
      }
    } else {
      if ($ARGV[0] == -1) {
        $out = $out . $in;
      } elsif ($ARGV[0] == -2) {
        $out = $out . "\n". $in;
      }
    }
  }
} else {
  $out = "=eval error!!="
}
print "$out"
