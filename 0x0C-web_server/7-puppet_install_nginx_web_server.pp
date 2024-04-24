# Install Nginx package
package { 'nginx':
  ensure => 'present',
}

exec { 'install nginx':
  command  => 'sudo apt-get update ; sudo apt-get -y install nginx',
  provider => shell,
}
exec {'Add the hello world':
  command  => 'echo "Hello World!" > /var/www/html/index.html',
  provider => shell,
}


exec { 'configure_redirect':
  command  => "/bin/sed -i 's/server_name _;/ \
            server_name _;\\n\\trewrite ^\\/redirect_me \
            https:\\/\\/www.youtube.com\\/watch?v=QH2-TGUlwu4 permanent;/' \
            /etc/nginx/sites-enabled/default",
  path     => '/bin',
  provider => shell,
}
