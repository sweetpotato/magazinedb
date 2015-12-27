#!/usr/bin/perl
use strict;
use warnings;
use utf8;
local $/=undef;
$_=<>;
m|<!-- Latest title -->\s*(.*?)\s*<!-- /Latest title/ -->|s or die;
print $1;
__END__
