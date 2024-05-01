#Add a custom header using puppet

exec {'update':
  command  => 'sudo apt-get -y update',
  unless   => 'dpkg -s nginx 2>/dev/null',
}

exec {'nginx':
  command  => 'sudo apt-get -y install nginx',
  unless   => 'dpkg -s nginx 2>/dev/null',
  require  => Exec['update'],
}

exec {'add_header':
  command   => 'sudo sed -i "s/server_name _;/server_name _;\n\tadd_header X-Served-By \$hostname;/" /etc/nginx/sites-available/default',
  unless    => 'grep -q "add_header X-Served-By \$hostname;" /etc/nginx/sites-available/default',
  require   => Exec['nginx'],
  subscribe => File['/etc/nginx/sites-available/default'],
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => Exec['add_header'],
}
