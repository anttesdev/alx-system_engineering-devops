#Add a custom header using puppet

exec {'update':
  command  => 'apt-get -y update',
}

exec {'nginx':
  command  => 'apt-get -y install nginx',
  require  => Exec['update'],
}

exec {'allow_http':
  command  => 'ufw allow Nginx HTTP',
  require  => Exec['nginx'],
}

file { '/var/www/html/index.nginx-debian.html':
  ensure  => present,
  content => 'Hello World!',
}

file { '/etc/nginx/sites-enabled/default':
  ensure  => present,
  content => "# Custom configuration for Nginx\nserver {\n\tserver_name _;\n\tadd_header X-Served-By \$hostname;\n\trewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;\n\tlisten 80 default_server;\n\terror_page 404 /error.html;\n\tlocation = /error.html {\n\t\troot /var/www/html;\n\t\tinternal;\n\t}\n}",
}

file { '/var/www/html/error.html':
  ensure  => present,
  content => "Ceci n'est pas une page",
}

service { 'nginx':
  ensure  => running,
  enable  => true,
  require => [Exec['nginx'], File['/var/www/html/index.nginx-debian.html'], File['/etc/nginx/sites-enabled/default'], File['/var/www/html/error.html']],
}
