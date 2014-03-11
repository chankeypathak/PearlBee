package PearlBee::REST;

use Dancer2;
use Dancer2::Plugin::DBIC;
use Dancer2::Plugin::REST;

prepare_serializer_for_format;

=haed

Get an array with all tags

=cut

get '/api/tags.:format' => sub {
  
	my $user = session('user');

    if ($user) {
	  my @tags = resultset('Tag')->all;
	  my @list;

	  push @list, $_->name foreach(@tags);
	  
	  return \@list;
   }
};

1;