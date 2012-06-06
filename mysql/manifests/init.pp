# Class: mysql
#
# This module manages mysql
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class mysql (
 $client_package = $mysql::params::client_package,
 $server_package = $mysql::params::server_package
) inherits mysql::params {
  
  class {"mysql::install": }
  class {"mysql::config": } 
  class {"mysql::service": }

  Class["mysql::install"] -> Class["mysql::config"] -> Class["mysql::service]
}
