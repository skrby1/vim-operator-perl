#!/usr/bin/perl -w

#now.pl 指定したテキストの前後等に現在時刻を付ける

use strict;

my @ymd = (localtime)[5,4,3];
$ymd[0] = sprintf("%02d", $ymd[0] % 100);
$ymd[1] = $ymd[1] + 1;
my @hms = (localtime)[2,1,0];
my $out = "[". join('/', @ymd). " ". join(':', @hms). "]";

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
