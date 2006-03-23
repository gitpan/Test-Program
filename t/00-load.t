#!perl -T -w

use Test::More tests => 1;

BEGIN {
    use_ok( 'Test::Program' );
}

diag( "Testing Test::Program $Test::Program::VERSION, Perl $], $^X" );
