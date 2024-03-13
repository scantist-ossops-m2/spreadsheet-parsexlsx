package Spreadsheet::ParseXLSX::Worksheet;

use strict;
use warnings;
use Scalar::Util ();

# VERSION

# ABSTRACT: wrapper class around L<Spreadsheet::ParseExcel::Worksheet>

=head1 DESCRIPTION

This is a simple subclass of L<Spreadsheet::ParseExcel::Worksheet> which does
not expose any new public behavior.  See the parent class for API details.

=cut

use Spreadsheet::ParseXLSX ();
use base 'Spreadsheet::ParseExcel::Worksheet';

# The object registry allows Cell objects to refer to Worksheets without
# the overhead of a weakened reference, which can add up over millions
# of cells.
our %_registry;

sub new {
  my $self = shift->next::method(@_);
  Scalar::Util::weaken($_registry{Scalar::Util::refaddr($self)} = $self);
  $self;
}

sub DESTROY {
  delete $_registry{Scalar::Util::refaddr($_[0])};
}

1;
