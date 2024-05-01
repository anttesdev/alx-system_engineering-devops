#Add a custom header using puppet

exec {'update':
  provider => shell,
  command  => 'sudo apt-get -y update',
}

exec {'nginx':
  provider => shell,
  command  => 'sudo apt-get -y install nginx',
}


exec { 'add_header':
  provider => shell,
  command  => 'sudo sed -i "s/include \/etc\/nginx\/sites-enabled\/\*;/include \/etc\/nginx\/sites-enabled\/\*;\n\tadd_header X-Served-By \"$hostname\";/" /etc/nginx/nginx.conf',
  before   => Exec['restart Nginx'],
}

exec { 'restart service':
  command  => 'sudo service nginx restart',
  provider => shell,
}
