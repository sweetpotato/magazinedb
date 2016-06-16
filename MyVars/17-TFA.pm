package MyVars;
use base Exporter;
our @EXPORT = qw(LoadPattern LoadKeys);

# U+3000 IDEOGRAPHIC SPACE (FULLWIDTH SPACE)
sub LoadPattern { qr!^(.*)\x{3000}(.*)$! }
sub LoadKeys { [qw(title author)] }

1;
