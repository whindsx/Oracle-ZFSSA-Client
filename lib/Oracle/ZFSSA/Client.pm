package Oracle::ZFSSA::Client;

use LWP::UserAgent;

# HTTP Return Codes
use constant CREATED => '201';

sub new {

   my $class = shift;

   my %params = @_;

   $self->{user} = $params{user};
   $self->{password} = $params{password};
   $self->{host} = $params{host};
   $self->{port} = $params{port};
   $self->{debug} = $params{debug};

   my $url = $self->{host} . ":" . $self->{port};
   $self->{url} = $url;

   # Generate the first request and get a valid Session
   #
   $url = $url . '/api/access/v1';
   
   my $header = ['X-Auth-User' => $self->{user}, 
                 'X-Auth-Key' => $self->{password}, 
                 'Content-Type' => 'application/json; charset=utf-8'];
   my $r = HTTP::Request->new('POST', $url, $header);
   my $uas = LWP::UserAgent->new();

   if ($self->{debug} == 1) {
      $uas->add_handler("request_send",  sub { shift->dump; return });
      $uas->add_handler("response_done", sub { shift->dump; return });
   }

   # Self signed Cert
   $uas->ssl_opts( verify_hostname => 0,
                  SSL_verify_mode => 'SSL_VERIFY_NONE' );
   my $res = $uas->request($r);

   my $session = "";
   if ($res->status_line =~ CREATED) {
      # All proceeding request should had this header set
      $session = $res->header('X-Auth-Session');
   } else {
      # You did not get a valid session
      die $res->status_line . ": Unable to get valid X-Auth-Session";
   }
   # 
   # End Session Building

   $self->{session} = $session;

   bless $self, $class;
   return $self;
}

sub call {

   my ($self,$method,$uri) = @_;

   my $url = $self->{url} . $uri; 
   my $header = ['X-Auth-Session' => $self->{session},'Content-Type' => 'application/json; charset=utf-8'];
   my $r = HTTP::Request->new($method, $url, $header);
   my $ua = LWP::UserAgent->new();

   if ($self->{debug} == 1) {
      $ua->add_handler("request_send",  sub { shift->dump; return });
      $ua->add_handler("response_done", sub { shift->dump; return });
   }

   # Self signed Cert
   $ua->ssl_opts( verify_hostname => 0,
                  SSL_verify_mode => 'SSL_VERIFY_NONE' );

   my $res = $ua->request($r);

   if ($res->is_success) {
      return $res->decoded_content;
   }
   return;
}

1;
