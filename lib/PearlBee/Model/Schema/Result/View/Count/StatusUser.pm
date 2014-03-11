package PearlBee::Model::Schema::Result::View::Count::StatusUser;

# This view is used for counting all stauts

use strict;
use warnings;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table_class('DBIx::Class::ResultSource::View');
__PACKAGE__->table('user');
__PACKAGE__->result_source_instance->is_virtual(1);

__PACKAGE__->result_source_instance->view_definition(
    q[
      SELECT
      	SUM( status = 'deactivated' ) AS deactivated,
      	SUM( status = 'activated') AS activated,
      	SUM( status = 'suspended' ) AS suspended,
      	COUNT(*) AS total
      FROM
      	user
    ]
);

__PACKAGE__->add_columns(
  "deactivated",
  { data_type => "integer", is_nullable => 0 },
  "activated",
  { data_type => "integer", is_nullable => 0 },
  "suspended",
  { data_type => "integer", is_nullable => 0 },
  "total",
  { data_type => "integer", is_nullable => 0 },
);

sub get_all_status_counts {
  my $self = shift;

  return ( $self->total, $self->activated, $self->deactivated, $self->suspended );
}

sub get_status_count {
  my ($self, $status) = @_;

  return ( $status eq 'activated' ) ? $self->activated : ( $status eq 'deactivated' ) ? $self->deactivated : $self->suspended;
}

1;