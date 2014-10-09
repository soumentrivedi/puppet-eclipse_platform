# == Class: eclipse_platform
#
# Install Eclipse Luna with Geppetto, DLTK, Subclipse, Grep Console, Egit integration.
#
# === Parameters
#
#  $method             => Install method (default wget, supported are wget, file, rpm)
#  $eclipsetype        => Eclipse platform type (jee, dsl, sdk) Default is jee 
#  $eclipseflavour     => Eclipse flavour to be installed (e.g. Luna, Keppler, etc.) Default & tested version is Luna
#  $package            => Eclipse package name (required when using rpm to install) Default is eclipse
#  $filesource         => Absolute path to the file source for eclipse (required when method is set to 'file')
#  $owner              => Owner for the eclipse install (default is root)
#  $group              => Group for the eclipse install (default is root)
#  $mode               => standard linux permission mode (default is 0644)
#  $wgettimeout        => Timeout for the wget download (3mins),
#  $timeout            => Timeout setting for eclipse plugin download
# 
# === Examples
# Create Eclipse Luna platform with default settings:
#  include eclipse_platform
#
# Create Eclipse Luna platform with custom plugins through hiera
#  class { 'eclipse_platform':
#    eclipse_type => "luna",
#    pluginshash  => hiera(eclipse_platform::pluginshash)
#  }
# - hiera file containing the following data (dltk, geppetto and subsclipse)
# (Indentation of data is important in yaml, remove # to use a sample hiera yaml
#eclipse_platform::pluginshash:
#  dltk:
#    timeout: 900
#    pluginrepositories: "http://download.eclipse.org/releases/luna/"
#    pluginius: "org.eclipse.dltk.ruby.feature.group"
#    vcheckforpluginfoldersn: "org.eclipse.dltk.ruby.feature.group"
#  geppetto:
#    timeout: 900
#    pluginrepositories: "https://geppetto-updates.puppetlabs.com/4.x"
#    pluginius: "com.puppetlabs.geppetto.feature.group"
#    vcheckforpluginfoldersn: "com.puppetlabs.geppetto.feature.group"
#  subclipse:
#    timeout: 900
#    pluginrepositories: "http://subclipse.tigris.org/update_1.10.x"
#    pluginius: "org.tigris.subversion.subclipse.feature.group,org.tigris.subversion.subclipse.mylyn.feature.group,org.tigris.subversion.clientadapter.feature.feature.group,org.tigris.subversion.clientadapter.javahl.feature.feature.group,org.tigris.subversion.subclipse.graph.feature.feature.group,org.tigris.subversion.clientadapter.svnkit.feature.feature.group"
#    vcheckforpluginfoldersn: "org.tigris.subversion.subclipse.feature.group,org.tigris.subversion.subclipse.mylyn.feature.group,org.tigris.subversion.clientadapter.feature.feature.group,org.tigris.subversion.clientadapter.javahl.feature.feature.group,org.tigris.subversion.subclipse.graph.feature.feature.group,org.tigris.subversion.clientadapter.svnkit.feature.feature.group"
#
#
# === Authors
#
# Author Name Soumen.Trivedi@arkayaventure.co.uk
#
# === Copyright
#
# Copyright 2014 Arkaya Venture Limited.
#
class eclipse_platform (
  $method             = $eclipse_platform::params::method,
  $eclipsetype        = $eclipse_platform::params::eclipsetype,
  $eclipseflavour     = $eclipse_platform::params::eclipseflavour,
  $package            = $eclipse_platform::params::package,
  $filesource         = $eclipse_platform::params::filesource,
  $owner              = $eclipse_platform::params::owner,
  $group              = $eclipse_platform::params::group,
  $mode               = $eclipse_platform::params::mode,
  $wgettimeout        = $eclipse_platform::params::wgettimeout,
  $timeout            = $eclipse_platform::params::timeout,
  $pluginshash         = $eclipse_platform::params::pluginshash) inherits eclipse_platform::params {
  class { 'eclipse_platform::setup': }
}
