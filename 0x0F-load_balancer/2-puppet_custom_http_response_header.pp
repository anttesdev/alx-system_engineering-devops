#Add a custom header using puppet

exec {'update':
  command  => 'apt-get -y update',
}

package {'nginx':
  ensure  => installed,
  require => Exec['update'],
}

file { '/var/www/html/index.html':
  ensure  => 'present',
  path    => '/var/www/html/index.html',
  content => 'Holberton School',
  require => Package['nginx'],
}

file_line { 'add a redirect me directive':
  ensure  => 'present',
  path    => '/etc/nginx/sites-available/default',
  after   => 'listen 80 default_server;',
  line    => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;',
  require => Package['nginx'],
}

file_line { 'add a header':
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
