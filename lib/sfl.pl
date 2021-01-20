#!/usr/bin/perl -w

#sfl.pl 指定したテキストをシャッフルして置き換える

use strict;
use List::Util;

my $delimiter = '';
$delimiter = $ARGV[0] if defined $ARGV[0];

my $out;
while(<STDIN>){
  if(chomp()){
    $out .= join($delimiter, List::Util::shuffle(split($delimiter, $_))). "\n";
  } else {
    $out .= join($delimiter, List::Util::shuffle(split($delimiter, $_)));
  }
}

chomp($out);
print "$out";
