#!/usr/bin/perl -w
use strict;
use LWP::UserAgent;

chomp(my $word = <STDIN>);
my $wordcnt = `osascript -e 'number of words of "$word"'`;
my $content = $word;

if ($wordcnt < 2){
  if ($word =~ /[^[:ascii:][:punct:]]/) {
    $word = `php -r 'echo rawurlencode($word);'`;
  }
  my ($meaning, $antonym);

#Create a user agent object
  my $ua = LWP::UserAgent->new;
  $ua->agent('PersonalDictCrawler/0.01');

#Create a reqest
  my $req = HTTP::Request->new(POST => "http://ejje.weblio.jp/content/$word");

#Pass reqest to the user agent and get a responce back
  my $res = $ua->request($req);

#Check the outcome of the responce
  if($res->is_success) {
    my $check;
    $meaning = $res->content;
    if ($meaning !~ /見つかりませんでした/s) {
      my $chk = $meaning =~ s/\A.+<td class=eGCoreDta>\n?(.+?)\n?<\/td>.+\Z/$1/s;
      if (!$chk) {
        $meaning =~ s/\A.+<td class=content-explanation>\n?(.+?)\n?<\/td>.+\Z/$1/s;
      }
      $check = 1;
    }
    if ($check) {
      $meaning = "[".$meaning."]";
    } else {
      $meaning = "";
    }
  } else {
    print $res->status_line, "\n";
  }

#Create a reqest
  $req = HTTP::Request->new(GET => "http://thesaurus.weblio.jp/antonym/content/$content");

#Pass reqest to the user agent and get a responce back
  $res = $ua->request($req);

#Check the outcome of the responce
  if($res->is_success) {
    my $check;
    $antonym = $res->content;
    if ($antonym !~ /見つかりませんでした/s) {
      $antonym =~ s/\A.+class=wtghtAntnm>\n?<a.+?>\n?(.+?)\n?<\/a>.+\Z/$1/s;
      $check = 1
    }
    if ($check) {
      $antonym = "<-> [".$antonym."]";
    } else {
      $antonym = "";
    }
  } else {
    print $res->status_line, "\n";
  }

  print "$content $meaning $antonym";

} else {
  my $to = $word =~ /[^[:ascii:][:punct:]]/ ? "ja/en/" : "en/ja/";
  my $type = ($to !~ /^e/) ? 1 : 0;
  my $encword = &url_encode($word,$type);
  if ($type) {
    ($word = $encword) =~ s/\+/%20/g;
  } else {
    ($word = $content) =~ s/\+/%20/g;
  }

  `open http://translate.google.com/?text=$encword#$to$word`;
  my $chk = `echo -n $?`;
  if ($chk) {
    print "=error=";
  } else {
    print "$content";
  }
}

sub url_encode($$) {
  my ($str,$type) = @_;
  if ($type) {
    $str =~ s/([^\w!\., ])/'%'.unpack('H2', $1)/eg;
    $str =~ tr/ /+/;
  } else {
    $str =~ s/[。]/'%'.unpack('H2', $1)/eg;
    $str =~ tr/ /+/;
  }
  return $str;
}
