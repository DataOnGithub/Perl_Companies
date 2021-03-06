#!/usr/bin/env perl 

use strict;
use warnings;

use autodie;

use YAML qw/ LoadFile /;
use Text::CSV;

my $csv = Text::CSV->new({ 
    binary              => 1,  
    auto_diag => 1,
    allow_whitespace => 1,
    always_quote => 1,
    eol => "\n",
    });

# TODO: Use Unicode::Collate based sorting here
my @companies = sort { lc $a->{name} cmp lc $b->{name} }
                     @{ LoadFile( 'Perl_Companies.yaml' ) };

open my $fh, '>', 'generated_company_list.csv';

$csv->print( $fh => [
    "Company Name",
    "Company Location",
    "Most Recent Posting"
]);

for( @companies ) {
    $csv->print( $fh => [
        @{$_}{qw/ name location most_recent_posting /}
    ]);
}


