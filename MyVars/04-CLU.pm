package MyVars;
use base Exporter;
our @EXPORT = qw(LoadPattern LoadKeys);

# U+FF0F FULLWIDTH SOLIDUS (FULLWIDTH SLASH)
# U+FF1C FULLWIDTH LESS-THAN SIGN
sub LoadPattern { qr!^(.*?)\x{FF0F}(.*?)(:?\x{FF1C}|$)! }
sub LoadKeys { [qw(title author)] }

1;
