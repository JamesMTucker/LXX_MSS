#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
use Text::CSV;

my $mss = $ARGV[0] or die;

my $csv = Text::CSV->new({
    binary => 1,
    auto_diag => 1,
    sep_char => ','
});

open(my $data, '<:encoding(utf8)', $mss) or die;

# Process the CSV File and Normalise Data Structure

# | id::int | rahlfs_sig::varchar(5) | name::varchar(50) | date::int | desc::varchar(100) | institution::foreignKey | instituition_city | institution_country | iiif_manifest::json

while (my $row = $csv->getline($data)){
    # rahlfs_sig 

    ## date (parse into two columns: beg and end)
    # date variety : \d+ || \d+ century || \d+th/\d+th century
    if ($row->[3] =~ m/(?<!\/)\d+th ?century/i){
        $row->[3] =~ s{(\d+)th ?century}{${1}00} unless $! > 10;
    } elsif ($row->[3] =~m/\d+th\/\d+th ?century/i){
        # TODO #1
        print "$row->[3]\n";
    }
    
}
if (not $csv->eof){
    $csv->error_diag();
}
close $data;