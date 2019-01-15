#!/usr/bin/perl
use warnings;

while(<STDIN>) {
  if(defined $ARGV[0] and $ARGV[0] == 1){
    tr/あ-ん/ア-ン/;
  }elsif(defined $ARGV[0] and $ARGV[0] == 2){
    tr/ア-ン/あ-ん/;
  }else{
    s/([ア-ン]+)/==$1==/g;
    tr/あ-ん/ア-ン/;
    while( $_ =~ s/==([ア-ン]+)==/$1/ ) {
      my $hira = $1;
      (my $kata = $hira) =~ tr/ア-ン/あ-ん/;
      $_ =~ s/$hira/$kata/;
    }
  }
  print;
};
