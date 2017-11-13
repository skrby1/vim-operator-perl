#!/usr/bin/perl -w
use strict;

my @md = (localtime)[4,3];
$md[0] = $md[0] + 1;
my @hms = (localtime)[2,1,0];
my $out = "[". join('/', @md). " ". join(':', @hms). "]";

my $in;
{
  local $/;
  $in = <STDIN>;
}

if($ARGV[0]){
  if ($ARGV[0] > 0) {
    my $n = "";
    $n = "\n" if $in !~ /\n\Z/;
    if ($ARGV[0] == 1) {
      $out = $in . $out;
    } elsif ($ARGV[0] == 2) {
      $out = $in . $n . $out;
    }
  } else {
    if ($ARGV[0] == -1) {
      $out = $out . $in;
    } elsif ($ARGV[0] == -2) {
      $out = $out . "\n". $in;
    }
  }
}

print "$out"
