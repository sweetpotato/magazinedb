#!/usr/bin/perl
use strict;
use warnings;
use utf8;
use List::Util qw(first);

use MyLoader;

binmode STDIN,  ':utf8';
binmode STDOUT, ':utf8';

require shift;
MyVars->import();

my $pattern = LoadPattern();
my $keys = LoadKeys();
my $master = LoadMaster(shift);

my $index = 1;
while(<STDIN>) {
  chomp;
  if(/^\s*$/) { next; }

  my @matched = (/$pattern/);
  if(!@matched) { next; }

  my $result = {};
  for my $key (@$keys) {
    local $_ = shift @matched;
    if(!defined($_)) {
      next;
    }
    s/^\s+|\s+$//g;
    # canonicalize:
    # U+{2460,2461}: CIRCLED DIGIT {ONE,TWO}
    s/[\x{2460}\x{2461}]//g;
    # U+FF10-U+FF19: FULLWIDTH DIGIT ZERO-NINE
    # U+FF21-U+FF3A: FULLWIDTH LATIN CAPITAL LETTER A-Z
    # U+FF41-U+FF5A: FULLWIDTH LATIN SMALL LETTER A-Z
    tr/\x{FF10}-\x{FF19}\x{FF21}-\x{FF3A}\x{FF41}-\x{FF5A}/0-9A-Za-z/;
    # U+FF01: FULLWIDTH EXCLAMATION MARK
    # U+FF1F: QUESTION EXCLAMATION MARK
    if(/[^\x{20}-\x{7E}]/) {
      # ignore "!?"
      s/!(?!\?)/\x{FF01}/g;
      s/(?<!!)\?/\x{FF1F}/g;
    }

    $result->{$key} = $_;
  }

  my $title = $result->{"title"};
  my $author = $result->{"author"};
  my $desc;
  my $row = first { $_->{title} eq $title } @$master;
  if(defined($row)) {
    $row->{marked} = 1;
    if(!defined($author)) { $author = $row->{author}; }
    $desc = defined($row->{desc}) ? "\t".$row->{desc} : '';
  } else {
    if(!defined($author)) { $author = 'FIXME'; }
    $desc = "\tFIXME";
  }

  print "${index}\t${title}\t${author}${desc}\n";
  ++$index;
}

my @unmarked = grep { !defined($_->{marked}) } @$master;
for my $row (@unmarked) {
  my $title  = $row->{title};
  my $author = $row->{author};
  my $desc   = $row->{desc} || "休載";
  print "-\t${title}\t${author}\t${desc}\n";
}

__END__
