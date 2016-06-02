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
    s/^\s+|\s+$//g;
    # canonicalize:
    # - U+{2460,2461}: CIRCLED DIGIT {ONE,TWO}
    s/[\x{2460}\x{2461}]//g;
    # - U+FF01: FULLWIDTH EXCLAMATION MARK
    if(index($_, '!') >= 0 && /[^\x{20}-\x{7E}]/) {
      s/!/\x{FF01}/g;
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
