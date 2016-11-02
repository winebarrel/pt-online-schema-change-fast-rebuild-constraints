package pt_online_schema_change_plugin;

use strict;

sub new {
  my ($class, %args) = @_;
  my $self = { %args };
  return bless $self, $class;
}

sub before_update_foreign_keys {
  my ($self, %args) = @_;
  my $dbh = $self->{aux_cxn}->dbh;

  if ($self->{execute}) {
    print "Disable foreign key checks\n";
    $dbh->do("set foreign_key_checks=0");
  }
}

sub after_update_foreign_keys {
  my ($self, %args) = @_;
  my $dbh = $self->{aux_cxn}->dbh;

  if ($self->{execute}) {
    print "Enable foreign key checks\n";
    $dbh->do("set foreign_key_checks=1");
  }
}

1;
