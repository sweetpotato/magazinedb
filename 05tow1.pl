#!/usr/bin/perl
use strict;
use warnings;
use utf8;
local $/=undef;
$_=<>;
m|(<section id="mag_pickup".*?</section>.*?</section>)|s or die;
print $1;
__END__
