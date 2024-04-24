# Install Nginx package
exec { 'install nginx':
  command  => 'sudo apt-get update && sudo apt-get -y install nginx',
  provider => shell,
  require  => Package['nginx'],
}

# Add the hello world index.html
exec { 'Add the hello world':
  command  => 'echo "Hello World!" > /var/www/html/index.html',
  provider => shell,
}

file_line { 'install':
  ensure => 'present',
  path   => 'etc/nginx/sites-enabled/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;"
}

service { 'nginx':
  ensure  => running,
  require => package['nginx'],
}  
