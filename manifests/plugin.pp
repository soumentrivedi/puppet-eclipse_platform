define eclipse_platform::plugin (
  $pluginrepositories = ['http://download.eclipse.org/releases/luna/'],
  $pluginius = [],
  $suppresserrors=false,
  $checkforpluginfolders=undef,
  $timeout=900,
) {
  $addpluginscmd = template("eclipse_platform/addplugins.erb")

  if $checkforpluginfolders == undef {
    $unless = undef
  } else {
    $unless = template('eclipse_platform/checkplugininstalled.erb')
  }

  exec {"${name}_ecplipseplugins":
    command=>$addpluginscmd,
    cwd=> $eclipse_platform::params::executefrom,
    path=> $eclipse_platform::params::execlaunchpaths,
    timeout => $timeout,
    unless=>$unless,
    logoutput=> on_failure,
  }
}