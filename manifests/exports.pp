define nfs::exports(
  $directory = $name,
  $clients,
  $options,
  $ensure = 'present'
) {
  if $ensure != 'present' and $ensure != 'absent' {
    fail("ensure must be set to either 'present' or 'absent'")
  }

  $line = create_exports_entry($directory,$clients,$options)

  notify { $line: }

  if $ensure != 'absent' {
    file { $directory:
      ensure => directory,
    }

    #concat::fragment { $directory:
    #  target => '/etc/exports',
    #  content => $line,
    #  require => File[$directory],
    #}
  } else {
    augeas { '/etc/exports':
      changes => [
        "rm title[*]${line}",      
      ],
    }
  }
}
