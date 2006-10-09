#!/usr/bin/perl
use strict;
use lib "lib";
use warnings;
use Benchmark;
use FindBin;

use XML::OPML::LibXML;
use XML::OPML;

my $file = $ARGV[0] || "presentation.opml";
my $path = "$FindBin::Bin/../t/samples/$file";

timethese 1000, {
    'XML::OPML' => \&xml_opml,
    'XML::OPML::LibXML' => \&xml_opml_libxml,
    'XML::OPML::LibXML walkdown' => \&xml_opml_libxml_walkdown,
};

sub xml_opml {
    my $opml = XML::OPML->new;
    $opml->parse($path);
    my $text = $opml->{outline}->[0]->{text};
}

sub xml_opml_libxml {
    my $doc = XML::OPML::LibXML->new->parse_file($path);
    my $text = $doc->outline->[0]->text;
}

sub xml_opml_libxml_walkdown {
    my $doc = XML::OPML::LibXML->new->parse_file($path);
    $doc->walkdown(sub { my $text = $_[0]->text; die });
}
