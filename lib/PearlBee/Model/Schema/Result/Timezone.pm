package PearlBee::Model::Schema::Result::Timezone;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

PearlBee::Model::Schema::Result::Timezone

=cut

__PACKAGE__->table("timezone");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 gmt

  data_type: 'varchar'
  is_nullable: 0
  size: 5

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 120

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "gmt",
  { data_type => "varchar", is_nullable => 0, size => 5 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 120 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 settings

Type: has_many

Related object: L<PearlBee::Model::Schema::Result::Setting>

=cut

__PACKAGE__->has_many(
  "settings",
  "PearlBee::Model::Schema::Result::Setting",
  { "foreign.timezone_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2014-02-08 04:37:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:q6PXdtW9q4UL6mmnndZYkw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
