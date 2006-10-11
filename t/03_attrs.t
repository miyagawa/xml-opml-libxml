use strict;
use Test::Base;
use XML::OPML::LibXML;

plan 'no_plan';

{
    my $doc = XML::OPML::LibXML->new->parse_file("t/samples/opml-nested.xml");
    my @outline = $doc->outline;
    is @outline, 1;
    is_deeply $outline[0]->attrs, { title => 'Subscriptions' };

    my $outline = ($outline[0]->children)[0];
    is_deeply $outline->attrs, { title => "Foo" };

    $outline = ($outline->children)[0];
    is_deeply $outline->attrs, {
        htmlUrl => "http://blog.bulknews.net/mt/",
        text => "blog.bulknews.net",
        title => "blog.bulknews.net",
        type => "rss",
        xmlUrl => "http://blog.bulknews.net/mt/index.rdf",
    };
}


