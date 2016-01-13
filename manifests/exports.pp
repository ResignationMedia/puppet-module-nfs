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

  file_line { $line:
    ensure => $ensure,
    line => $line,
    path => '/etc/exports',
    notify => Exec["exportfs_${directory}"]
  }

  exec { "exportfs_${directory}":
    path => '/usr/sbin',
    command => 'exportfs -ra',
    refreshonly => true,
  }
}
