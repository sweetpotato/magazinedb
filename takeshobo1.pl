#!/usr/bin/perl
use strict;
use warnings;
use utf8;
local $/=undef;
$_=<>;
m|<!-- AddClips Code END -->\s*(.*?)\s*</div>|s or die;
print $1;
__END__
