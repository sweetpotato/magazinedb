package MyVars;
use base Exporter;
our @EXPORT = qw(LoadPattern LoadKeys);

# U+300C LEFT CORNER BRACKET
# U+300D RIGHT CORNER BRACKET
# U+FF08 FULLWIDTH LEFT PARENTHESIS
# U+FF09 FULLWIDTH RIGHT PARENTHESIS
sub LoadPattern { qr/\x{300C}(.*?)\x{300D}(?:\(|\x{FF08})(.*?)(?:\)|\x{FF09})/ }
sub LoadKeys { [qw(title author)] }

1;
