#!/usr/bin/perl
use strict;
use warnings;
use utf8;
binmode STDIN, ':encoding(cp932)';
binmode STDOUT, ':utf8';
local $/=undef;
$_=<>;
### "\s*(.*?\r\n)\s*" to preserve the last CRLF
m|<ul class="lineup">\s*(.*?\r\n)\s*<!-- /Lineup -->|s or die;
$_=$1;
while(m!(.*?)\r\n!g) {
  my $x=$1;
  # Remove HTML tags
  $x =~ s/<[^>]*>//g;
  # WAVE DASH (U+301C) to FULLWIDTH TILDE (U+FF5E)
  $x=~s/\x{301C}/\x{FF5E}/g;
  print "$x\n";
}
__END__
