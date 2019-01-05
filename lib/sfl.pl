#!/usr/bin/perl -w

#sfl.pl 指定したテキストをシャッフルして置き換える

use strict;
use List::Util;

my $out;
while(<STDIN>){
  if(chomp()){
    $out .= join('', List::Util::shuffle(split('', $_))). "\n";
  } else {
    $out .= join('', List::Util::shuffle(split('', $_)));
  }
}

chomp($out);
print "$out";
