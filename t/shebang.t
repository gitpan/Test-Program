#!perl -T -w

use strict;
use warnings;

use Test::More tests => 2;

BEGIN {
    use_ok( 'Test::Program' );
}

my $switches = Test::Program::shebang_switches( 't/00-load.t' );
is( $switches, '-T -w', 'Switches are right' );
