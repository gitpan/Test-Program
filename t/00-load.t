#!perl -T -w

use warnings;
use strict;

use Test::More tests => 1;

BEGIN {
    use_ok( 'Test::Program' );
}

diag( "Testing Test::Program $Test::Program::VERSION, Perl $], $^X" );
