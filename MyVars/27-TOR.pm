package MyVars;
use base Exporter;
our @EXPORT = qw(LoadPattern LoadKeys);

sub LoadPattern { qr!^(.*?)$! }
sub LoadKeys { [qw(title)] }

1;
