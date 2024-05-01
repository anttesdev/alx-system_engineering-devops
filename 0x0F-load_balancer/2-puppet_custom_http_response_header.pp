#Add a custom header using puppet

exec {'update':
  provider => shell,
  command  => 'sudo apt-get -y update',
}

package { 'nginx':
  ensure => installed,
}

exec {'add header':
  provider => shell,
  command  => 'sudo sed -i "s/server_name _;/server_name _;\n\tadd_header X-Served-By \$hostname;\n\trewrite ^\/redirect_me https:\/\/www.youtube.com\/watch?v=QH2-TGUlwu4 permanent;/" /etc/nginx/sites-available/default',
}

service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => Exec['add header'],
}
