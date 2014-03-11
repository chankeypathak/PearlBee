package PearlBee::Authentication;

use Dancer2;
use Dancer2::Plugin::DBIC;
use PearlBee::Password;

=head

index

=cut

get '/admin' => sub {
  my $user = session('user');

  redirect('/dashboard') if ( $user );
  template 'login', {}, { layout => 'admin' };
};

=head

login metehod

=cut

post '/login' => sub {
  my $password = params->{password};
  my $username = params->{username};

  my $user = resultset("User")->search({
      username => $username,
      -or => [
      	status => 'activated',
      	status => 'deactivated'
      ]
    })->first;
  
  my $password_hash = generate_hash($password, $user->salt) if $user;
  if($user && $user->password eq $password_hash->{hash}) {
    
    my $user_obj->{is_admin} = $user->is_admin;
    $user_obj->{role}        = $user->role;
    $user_obj->{id}          = $user->id;

    session user => $user_obj;
    session user_id => $user->id;
    redirect('/dashboard');
  }
  else {
    template 'login', { warning => "Incorrect login" }, { layout => 'admin' };
  }
};

=head

logout method

=cut

get '/logout' => sub {
  context->destroy_session;

  template 'login', {}, { layout => 'admin' };
};

true;
