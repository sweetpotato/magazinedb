package MyVars;
use base Exporter;
our @EXPORT = qw(LoadPattern LoadKeys);

# U+300E LEFT WHITE CORNER BRACKET
# U+300F RIGHT WHITE CORNER BRACKET
sub LoadPattern { qr/^(.*?)\x{300E}(.*?)\x{300F}/ }
sub LoadKeys { [qw(author title)] }

1;
