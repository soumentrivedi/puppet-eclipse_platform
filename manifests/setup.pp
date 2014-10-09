class eclipse_platform::setup {
  # creates tests for commandline execution
  $wgetcreates = "${eclipse_platform::params::downloadpath}${eclipse_platform::params::downloadfile}"
  $finalcreates = "${eclipse_platform::params::installpath}eclipse"
  $simlinkcreates = "${eclipse_platform::params::simlinkto}/eclipse"
  $applicationpath = "${eclipse_platform::params::installpath}/eclipse/eclipse"

  # commands to be run by exec
  $wgetcommand = "wget -O '${wgetcreates}' '${eclipse_platform::params::downloadurl}'"
  $unpackcommand = "tar -C '${eclipse_platform::params::installpath}' -zxvf '${wgetcreates}'"
  $modeclipse = "chmod -R 775 '${finalcreates}'"
  $simlinktobin = "ln -s '${applicationpath}' '${simlinkcreates}'"

  if "${eclipse_platform::method}" == 'wget' {
    # Downloads eclipse package
    exec { "geteclipse":
      command   => $wgetcommand,
      cwd       => $eclipse_platform::params::executefrom,
      path      => $eclipse_platform::params::execlaunchpaths,
      creates   => $wgetcreates,
      logoutput => on_failure,
      timeout   => "${eclipse_platform::wgettimeout}",
    }

    # Decompresses eclipse
    exec { "upackeclipse":
      command   => $unpackcommand,
      cwd       => $eclipse_platform::params::executefrom,
      path      => $eclipse_platform::params::execlaunchpaths,
      creates   => $finalcreates,
      logoutput => on_failure,
      require   => Exec["geteclipse"]
    }

    # Mod eclipse
    exec { "modeclipse":
      command   => $modeclipse,
      cwd       => $eclipse_platform::params::executefrom,
      path      => $eclipse_platform::params::execlaunchpaths,
      logoutput => on_failure,
      require   => Exec["upackeclipse"]
    }

    # Make a simlink in bin
    exec { "simlinkeclipse":
      command   => $simlinktobin,
      cwd       => $eclipse_platform::params::executefrom,
      path      => $eclipse_platform::params::execlaunchpaths,
      creates   => $simlinkcreates,
      logoutput => on_failure,
      require   => Exec["modeclipse"]
    }

  } elsif "${eclipse_platform::method}" == 'file' {
    file { "eclipsefile":
      path   => $wgetcreates,
      owner  => "${eclipse_platform::owner}",
      group  => "${eclipse_platform::group}",
      mode   => "${eclipse_platform::mode}",
      source => "${eclipse_platform::filesource}",
    }

    # Mod eclipse
    exec { "modeclipse":
      command   => $modeclipse,
      cwd       => $eclipse_platform::params::executefrom,
      path      => $eclipse_platform::params::execlaunchpaths,
      logoutput => on_failure,
      require   => Exec["upackeclipse"]
    }

    # Make a simlink in bin
    exec { "simlinkeclipse":
      command   => $simlinktobin,
      cwd       => $eclipse_platform::params::executefrom,
      path      => $eclipse_platform::params::execlaunchpaths,
      creates   => $simlinkcreates,
      logoutput => on_failure,
      require   => Exec["modeclipse"]
    }

  } elsif "${eclipse_platform::method}" == 'package' {
    package { "eclipse":
      name   => "eclipse",
      ensure => "${eclipse_platform::method}",
    }
  }
  
  if ("${eclipse_platform::method}" == 'file') or ("${eclipse_platform::method}" == 'wget') {
    # Put the eclipse icon on the desktop
    file { "eclipse.desktop":
      path    => "${eclipse_platform::params::desktopfilepath}/eclipse.desktop",
      ensure  => "present",
      content => template("eclipse_platform/eclipse.desktop.erb")
    }
  }
create_resources("::eclipse_platform::plugin",$eclipse_platform::pluginshash)
}