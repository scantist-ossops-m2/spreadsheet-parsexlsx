package Spreadsheet::ParseXLSX::Cell;

use strict;
use warnings;

# VERSION

# ABSTRACT: wrapper class around L<Spreadsheet::ParseExcel::Cell>

use Spreadsheet::ParseXLSX ();
use base 'Spreadsheet::ParseExcel::Cell';


=head1 SYNOPSIS

  use Spreadsheet::ParseXLSX::Cell;

  my $cell = Spreadsheet::ParseXLSX::Cell->new(
    Sheet => $sheet,
    Row => $row,
    Col => $row,
    ...
  );

  my $isMerged = $cell->is_merged();
  # see Spreadsheet::ParseExcel::Cell for further documentation

=cut

sub DESTROY {
  my $self = shift;

  #$self->SUPER::DESTROY();

  undef $self->{Sheet}; # break circular dependencies
}

=method is_merged($sheet, $row, $col)

Returns true if the cell is merged being part of the given sheet, located at
the given row and column. Returns undef if the current cell is not connected to
any sheet:

C<$sheet> defaults to the cell's C<{Sheet}> property,
C<$row> to C<{Row}> and
C<$col> to the C<{Col}>.


=cut

sub is_merged {
  my ($self, $sheet, $row, $col) = @_;

  return $self->{Merged} if defined $self->{Merged};

  $sheet //= $self->{Sheet};
  $row //= $self->{Row};
  $col //= $self->{Col};

  return unless defined $sheet && defined $row && defined $col;

  return $self->{Merged} = Spreadsheet::ParseXLSX::_is_merged(undef, $sheet, $row, $col);
}

1;
