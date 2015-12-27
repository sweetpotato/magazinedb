#!/usr/bin/perl
use strict;
use warnings;
use utf8;

(@ARGV == 1) or die;
my($p) = @ARGV;

local $/ = undef;

local $_ = <STDIN>;
/$p/s or die;
print $1;

__END__
