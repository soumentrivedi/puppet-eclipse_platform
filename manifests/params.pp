class eclipse_platform::params (
  $method             = 'wget',
  $eclipsetype        = 'jee',
  $eclipseflavour     = 'luna',
  $package            = 'eclipse',
  $filesource         = undef,
  $owner              = 'root',
  $group              = 'root',
  $mode               = '0644',
  $wgettimeout        = 1800,
  $timeout            = 900) {
  case $::operatingsystem {
    'centos', 'redhat', 'fedora', 'OracleLinux' : {
      $downloadpath = '/usr/src/'
      $installpath = '/usr/lib/'
      $desktopfilepath = '/usr/share/applications/'
      $simlinkto = '/usr/bin/'

      case $::architecture {
        'x86_64' : { $downloadfile = "eclipse-${eclipsetype}-${eclipseflavour}-SR1-linux-gtk-x86_64.tar.gz" }
        default  : { $downloadfile = "eclipse-${eclipsetype}-${eclipseflavour}-SR1-linux-gtk.tar.gz" }
      }
    }

    'windows' : {
      $downloadpath = 'C:\temp'
      $installpath = 'C:\Program Files (x86)'
      $desktopfilepath = 'C:\Program Files (x86)'
      $simlinkto = 'C:\eclipse'

      case $::architecture {
        'x86_64' : { $downloadfile = "eclipse-${eclipsetype}-${eclipseflavour}-SR1-win32-x86_64.zip" }
        default  : { $downloadfile = "eclipse-${eclipsetype}-${eclipseflavour}-SR1-win32.zip" }
      }
    }
    default   : {
      $downloadpath = '/usr/src/'
      $installpath = '/usr/lib/'
      $desktopfilepath = '/usr/share/applications/'
      $simlinkto = '/usr/bin/'

      case $::architecture {
        'x86_64' : { $downloadfile = "eclipse-${eclipsetype}-${eclipseflavour}-SR1-linux-gtk-x86_64.tar.gz" }
        default  : { $downloadfile = "eclipse-${eclipsetype}-${eclipseflavour}-SR1-linux-gtk.tar.gz" }
      }
    }
  }
  $execlaunchpaths = ["/usr/bin", "/usr/sbin", "/bin", "/sbin", "/etc"]
  $executefrom = "/tmp/"
  $downloadurl = "http://www.mirrorservice.org/sites/download.eclipse.org/eclipseMirror/technology/epp/downloads/release/${eclipseflavour}/SR1/${downloadfile}"
  $pluginshash = {
    'dltk'                => {
      timeout               => $timeout,
      pluginrepositories    => "http://download.eclipse.org/releases/luna/",
      pluginius             => "org.eclipse.dltk.ruby.feature.group",
      checkforpluginfolders => "org.eclipse.dltk.ruby.feature.group",
    }
    ,
    'geppetto'            => {
      timeout               => $timeout,
      pluginrepositories    => "https://geppetto-updates.puppetlabs.com/4.x",
      pluginius             => "com.puppetlabs.geppetto.feature.group",
      checkforpluginfolders => "com.puppetlabs.geppetto.feature.group",
    }
    ,
    'yedit'               => {
      timeout               => $timeout,
      pluginrepositories    => "http://dadacoalition.org/yedit",
      pluginius             => "org.dadacoalition.yedit.feature.group",
      checkforpluginfolders => "org.dadacoalition.yedit.feature.group",
    }
    ,
    'grepconsole'         => {
      timeout               => $timeout,
      pluginrepositories    => "http://eclipse.schedenig.name",
      pluginius             => "name.schedenig.eclipse.grepconsole.feature.group",
      checkforpluginfolders => "name.schedenig.eclipse.grepconsole.feature.group",
    }
    ,
    'subclipse'           => {
      timeout               => $timeout,
      pluginrepositories    => "http://subclipse.tigris.org/update_1.10.x",
      pluginius             => "org.tigris.subversion.subclipse.feature.group,org.tigris.subversion.subclipse.mylyn.feature.group,org.tigris.subversion.clientadapter.feature.feature.group,org.tigris.subversion.clientadapter.javahl.feature.feature.group,org.tigris.subversion.subclipse.graph.feature.feature.group,org.tigris.subversion.clientadapter.svnkit.feature.feature.group",
      checkforpluginfolders => "org.tigris.subversion.subclipse.feature.group,org.tigris.subversion.subclipse.mylyn.feature.group,org.tigris.subversion.clientadapter.feature.feature.group,org.tigris.subversion.clientadapter.javahl.feature.feature.group,org.tigris.subversion.subclipse.graph.feature.feature.group,org.tigris.subversion.clientadapter.svnkit.feature.feature.group",
    }
    ,
    'gconsole'            => {
      timeout               => $timeout,
      pluginrepositories    => "http://rherrmann.github.io/gonsole/repository/",
      pluginius             => "com.codeaffine.gonsole.egit.feature.feature.group,com.codeaffine.gonsole.feature.feature.group",
      checkforpluginfolders => [
        "com.codeaffine.gonsole.egit.feature.feature.group",
        "com.codeaffine.gonsole.feature.feature.group"],
    }
    ,
  }
}
