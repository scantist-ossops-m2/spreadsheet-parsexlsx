#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Scalar::Util 'weaken';

use Spreadsheet::ParseXLSX;

my $wb = Spreadsheet::ParseXLSX->new->parse('t/data/Test.xlsx');
my $ws1 = $wb->worksheet(0);
my $cell = $ws1->get_cell(0,0);

ok(defined $wb && defined $ws1 && defined $cell, '3 object references');

weaken($wb);
weaken($ws1);
weaken($cell);

ok(!defined $wb, 'workbook freed');
ok(!defined $ws1, 'worksheet freed');
ok(!defined $cell, 'cell freed' );

done_testing;
