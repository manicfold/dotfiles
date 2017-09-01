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
package %HERE%;
###################################################################
#
###################################################################
use strict;
use warnings;

our @ISA = qw(Exporter);
our %EXPORT_TAGS = (
   'all' => [ qw( ) ],
);
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw();
our $VERSION = '1.00';
require Exporter;

###################################################################


