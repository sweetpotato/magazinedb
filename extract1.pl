#!/usr/bin/perl
use strict;
use warnings;
use utf8;

(@ARGV == 1) or die;
my($pattern) = @ARGV;

local $/ = undef;

local $_ = <STDIN>;
/$pattern/s or die;
print $1;

__END__
