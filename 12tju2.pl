#!/usr/bin/perl
use strict;
use warnings;
use utf8;
binmode STDIN, ':encoding(euc-jp)';
binmode STDOUT, ':utf8';
local $/=undef;
$_=<>;
m!"text_read">.*?"text_read">\s*(.*?)(?:<BR>|\s)*</td>!s or die;
$_=$1;
# LEFT CORNER BRACKET (U+300C)
while(m!\s*(\x{300C}.*?)\s*(?:<BR>|\z)!gs) {
  my $x=$1;
  # WAVE DASH (U+301C) to FULLWIDTH TILDE (U+FF5E)
  $x=~s/\x{301C}/\x{FF5E}/g;
  print "$x\n";
}
__END__
