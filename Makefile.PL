use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Test::Program',
    AUTHOR              => 'Andy Lester <andy@petdance.com>',
    VERSION_FROM        => 'lib/Test/Program.pm',
    ABSTRACT_FROM       => 'lib/Test/Program.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Exporter' => 0,
        'Test::More' => 0,
        'Test::Builder::Tester' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-Program-*' },
);
