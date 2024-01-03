#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;
 
use Test::PerlTidy qw( run_tests );
 
run_tests(
  path => 'lib',
  perltidyrc => '.perltidyrc',
  exclude => [ qr{\.t$}, 'inc/'],
  mute => 1
);


done_testing;
