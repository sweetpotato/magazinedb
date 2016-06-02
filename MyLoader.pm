package MyLoader;
use base Exporter;
our @EXPORT = qw(LoadMaster LoadVolume);

sub LoadMaster {
  my $path = shift;
  open my $fh, '<', $path or die;
  binmode $fh, ':utf8';
  my $pattern = qr/^(.*?)\t(.*?)(?:\t(.*?))?$/;
  my @master = ();
  while(<$fh>) {
    chomp;
    /$pattern/ or die;
    my %row = (title => $1, author => $2, desc => ($3 || undef), raw => $_);
    push @master, \%row;
  }
  close $fh;
  return \@master;
}

sub LoadVolume {
  my $path = shift;
  open my $fh, '<', $path or die;
  binmode $fh, ':utf8';
  my $pattern = qr/^(.*?)\t(.*?)\t(.*?)(?:\t(.*?))?$/;
  my @volume = ();
  while(<$fh>) {
    chomp;
    /$pattern/ or die;
    my %row = (position => $1, title => $2, author => $3, desc => ($4 || undef), raw => $_);
    push @volume, \%row;
  }
  close $fh;
  return \@volume;
}

1;
