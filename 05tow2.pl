#!/usr/bin/perl
use strict;
use warnings;
use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
local $/=undef;
$_=<>;
while(m!<h1 class="mag_pickup_title">\s*(.*?)\s*<[^>]*>\s*<[^>]*>\s*(.*?)\s*<!gs) {
  my $x="$1$2";
  # WAVE DASH (U+301C) to FULLWIDTH TILDE (U+FF5E)
  $x=~s/\x{301C}/\x{FF5E}/g;
  print "$x\n";
}
__END__
