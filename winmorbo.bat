:loop
@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
@echo on
cmd /C perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
@echo on
cmd /C perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!perl
#line 15
use Mojo::Base -strict;

use Mojo::Server::Morbo;

# Fix morbo run subroutine
# When files is modified, server exit.
{
  no warnings 'redefine';

  sub Mojo::Server::Morbo::run {
    my ($self, $app) = @_;
    
    unshift @{$self->backend->watch}, $0 = $app;
    $self->{modified} = 1;

    until ($self->{finished} && !$self->{worker}) {
      $self->_manage;
      if ($self->{modified} && $self->{worker}) {
        exit 0;
      }
    }
    exit 0;
  }
}

use Mojo::Util qw(extract_usage getopt);

getopt
  'b|backend=s' => \$ENV{MOJO_MORBO_BACKEND},
  'h|help'      => \my $help,
  'l|listen=s'  => \my @listen,
  'm|mode=s'    => \$ENV{MOJO_MODE},
  'v|verbose'   => \$ENV{MORBO_VERBOSE},
  'w|watch=s'   => \my @watch;

die extract_usage if $help || !(my $app = shift);
my $morbo = Mojo::Server::Morbo->new;
$morbo->daemon->listen(\@listen) if @listen;
$morbo->backend->watch(\@watch)  if @watch;
$morbo->run($app);

__END__
:endofperl
goto :loop
