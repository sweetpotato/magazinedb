#!/usr/bin/perl
use strict;
use warnings;
use utf8;
binmode STDIN, ':encoding(cp932)';
binmode STDOUT, ':utf8';
local $/=undef;
$_=<>;
m!<ul class="disc mb30">(.*?)</ul>!s or die;
$_=$1;
while(m!<li>\s*(.*?)\s*</li>!gs) {
  my $x=$1;
  # WAVE DASH (U+301C) to FULLWIDTH TILDE (U+FF5E)
  $x=~s/\x{301C}/\x{FF5E}/g;
  print "$x\n";
}
__END__
