#!perl -w

use 5.6.1;

use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Test::Program',
    AUTHOR              => 'Andy Lester <andy@petdance.com>',
    VERSION_FROM        => 'Program.pm',
    ABSTRACT_FROM       => 'Program.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Exporter' => 0,
        'Test::Builder::Tester' => 0,
        'Test::More' => 0,
        'Test::Pod' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-Program-*' },
);

package MY;
sub MY::postamble {
    my $postamble = <<"MAKE_FRAG";
.PHONY: critic

critic :
	perlcritic -1 -q -profile perlcriticrc Program.pm t/*.t

MAKE_FRAG

    return $postamble;
}
