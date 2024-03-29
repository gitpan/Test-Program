#!perl -w

use warnings;
use strict;

use Test::More tests => 7;
use Test::Builder::Tester;
use Test::Builder::Tester::Color;
use Test::Program;

BEGIN {
    use_ok( 'Test::Program' );
}

CLEAN: {
    my $program = 't/bin/clean.pl';

    test_out( "ok 1 - $program compiles" );
    my $ok = program_compiles_ok( $program );
    test_test( "program_compiles_ok( '$program' ) passes" );
    ok( $ok, 'And returns true' );
}

FAILS: {
    my $program = 't/bin/non-compiling.pl';

    test_out( "not ok 1 - $program compiles" );
    test_fail( +6 );
    test_diag(
        'syntax error at t/bin/non-compiling.pl line 8, near "= ;"',
        't/bin/non-compiling.pl had compilation errors.',
        'Returned error code 255',
    );
    my $ok = program_compiles_ok( $program );
    test_test( "program_compiles_ok( '$program' ) fails" );
    ok( !$ok, 'And returns false' );
}

WARNINGS: {
    my $program = 't/bin/warnings.pl';

    test_out( "not ok 1 - $program compiles" );
    test_fail( +7 );
    test_diag(
        'Warnings:',
        qq{Name "main::x" used only once: possible typo at $program line 3.},
        "$program syntax OK",
    );

    my $ok = program_compiles_ok( $program );
    test_test( "program_compiles_ok( '$program' ) fails" );
    ok( !$ok, 'And returns false' );
}
