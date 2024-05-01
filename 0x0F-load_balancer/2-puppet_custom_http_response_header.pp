#Add a custom header using puppet

exec {'update':
  provider => shell,
  command  => 'sudo apt-get -y update',
}

exec {'nginx':
  provider => shell,
  command  => 'sudo apt-get -y install nginx',
}

exec {'add header':
  provider => shell,
  command  => 'sudo sed -i "s/server_name _;/server_name _;\n\tadd_header X-Served-By \$hostname;" /etc/nginx/sites-available/default',
}

exec { 'restart service':
  command  => 'sudo service nginx restart',
  provider => shell,
} 
