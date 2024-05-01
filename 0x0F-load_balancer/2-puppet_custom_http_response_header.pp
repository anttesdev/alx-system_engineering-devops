#Add a custom header using puppet

exec {'update':
  command  => 'apt-get -y update',
}

package {'nginx':
  ensure  => installed,
  require => Exec['update'],
}

file_line { 'addHeader':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  after   => 'listen 80 default_server;',
  line    => 'add_header X-Served-By $hostname;',
  require => Package['nginx'],
}

service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
