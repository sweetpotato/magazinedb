package MyVars;
use base Exporter;
our @EXPORT = qw(LoadPattern LoadKeys);

# U+300C LEFT CORNER BRACKET
# U+300D RIGHT CORNER BRACKET
sub LoadPattern { qr!^(.*?)\x{300C}(.*?)\x{300D}$! }
sub LoadKeys { [qw(author title)] }

1;
