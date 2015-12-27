#!/usr/bin/perl
use strict;
use warnings;
use utf8;
local $/=undef;
$_=<>;
m!(<table width="100%".*?</table>)!s or die;
print $1;
__END__
