#!/usr/bin/perl
use strict;
use warnings;
use utf8;

(@ARGV == 3) or die;
my($encode, $pattern, $qattern) = @ARGV;

binmode STDIN, $encode;
binmode STDOUT, ':utf8';
local $/ = undef;

local $_ = <STDIN>;
/$pattern/s or die;
local $_ = $1;

while(/$qattern/gs) {
  my $x = (defined($2)) ? "$1$2" : $1;
  # Remove HTML tags
  $x =~ s/<[^>]*>//g;
  # Trimming
  $x =~ s/^\s*|\s*$//g;
  # WAVE DASH (U+301C) to FULLWIDTH TILDE (U+FF5E)
  $x =~ s/\x{301C}/\x{FF5E}/g;
  print "$x\n";
}

__END__
