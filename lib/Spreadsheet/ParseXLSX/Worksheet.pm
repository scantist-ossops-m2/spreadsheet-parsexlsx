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

=method new()

creates a new worksheet and adds it to the registry

=cut

sub new {
  my $self = shift->SUPER::new(@_);

  Scalar::Util::weaken($_registry{Scalar::Util::refaddr($self)} = $self);

  return $self;
}

=method DESTROY()

removes the object from the registry while destroying it

=cut

sub DESTROY {
  delete $_registry{Scalar::Util::refaddr($_[0])};
}

1;
