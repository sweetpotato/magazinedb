package MyVars;
use base Exporter;
our @EXPORT = qw(LoadPattern LoadKeys);

# U+FF0F FULLWIDTH SOLIDUS
# U+FF1C FULLWIDTH LESS-THAN SIGN
# U+FF1E FULLWIDTH GREATER-THAN SIGN
sub LoadPattern { qr!^([^\x{FF0F}]*)(?:\x{FF0F}([^\x{FF1C}]*)(?:\x{FF1C}(.*?)\x{FF1E})?)?$! }
sub LoadKeys { [qw(title author desc)] }

1;
