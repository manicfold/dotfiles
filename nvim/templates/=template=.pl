#!/usr/bin/env perl
###################################################################
#         FILE: %FFILE%
# SW-COMPONENT: Software update
#  DESCRIPTION: Software update is responsible for updating the 
#               firmware of the targets.
#    COPYRIGHT: %LICENSE%
#       AUTHOR: %USER% <%MAIL%>
#
# The reproduction, distribution and utilization of this file as
# well as the communication of its contents to others without express
# authorization is prohibited. Offenders will be held liable for the
# payment of damages. All rights reserved in the event of the grant
# of a patent, utility model or design.
###################################################################

use strict;
use warnings;

use Getopt::Long;                   # for option parsing

# --- main program ---
__PACKAGE__->main() unless caller();

sub main {
   # parse command line arguments and setup variables
   my %options = (
      # -- Strings
      example => '',
      # -- Flags
      usage   => 0,
   );
   _read_options(\%options);
   %HERE%
}

### Function ###
#    Purpose: Evaluate options given to the script.
# Parameters: HashRef - Options
#    Returns: None
sub _read_options {
   my ( $options_ref ) = @_;

   GetOptions(
      "example=s"  => \$options_ref->{example},
      "usage|help" => \$options_ref->{usage},
   ); 

   # verify mandatory options
   for my $name ( ('example') ) {
      if (!$options_ref->{$name}) {
         # error
      }
   }

   # other checks 
   if ( $options_ref->{usage} ) {
      # usage
   }
}
