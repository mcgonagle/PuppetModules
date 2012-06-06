# Class: httpd::vhost
#
# This module manages httpd::vhost
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
class httpd::vhost(
  $port,
  $docroot,
  $ssl = true,
  $template = "httpd/vhost.conf.erb",
  $priority,
  $serveraliases = "" ) {
  file {"/etc/httpd/vhosts.d":
    ensure => directory,
    owner => "${owner}",
    group => "${group}",
    mode => "0755",
  }

  file {"/etc/httpd/conf.d/vhosts.conf"
    content => template(${template}),
    owner => "$owner",
    group => "$group",
    mode => "777",
    require => File["/etc/httpd/vhosts.d"], 
  }
}
