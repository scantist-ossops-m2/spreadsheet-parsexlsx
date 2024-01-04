#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

use Spreadsheet::ParseXLSX;

my $wb = Spreadsheet::ParseXLSX->new->parse('t/data/bug-md-7.xlsx');
isa_ok($wb, 'Spreadsheet::ParseExcel::Workbook');

done_testing;


