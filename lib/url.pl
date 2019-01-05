#!/usr/bin/perl -w

#url.pl 指定するテキストをURLエンコードする。

use strict;

while(<>){
  print `php -r 'echo rawurlencode("$_");'`
}
