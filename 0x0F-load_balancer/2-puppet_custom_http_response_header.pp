#Add a custom header using puppet

exec {'update':
  command  => 'apt-get -y update',
}

package {'nginx':
  ensure  => installed,
  require => Exec['update'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "# Custom HTTP header configuration\nserver {\n\tlisten 80 default_server;\n\tlisten [::]:80 default_server;\n\n\tserver_name _;\n\n\t# Add custom HTTP header\n\tadd_header X-Served-By \$hostname;\n\n\t# other configurations...\n}",
  require => Package['nginx'],
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}
