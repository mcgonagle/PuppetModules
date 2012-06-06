# Class: httpd::install
#
# This module manages httpd::install
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
class httpd::install {
  package { "httpd": ensure => installed, }
}
