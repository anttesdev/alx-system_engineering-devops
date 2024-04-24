# Install Nginx package

exec { 'install nginx':
  command  => 'sudo apt-get update ; sudo apt-get -y install nginx',
  provider => shell,
  require  => Package['nginx'],
}
exec {'Add the hello world':
  command  => 'echo "Hello World!" > /var/www/html/index.html',
  provider => shell,
}


exec { 'configure_redirect':
  command  => "/bin/sed -i 's/listen 80 default_server;/ \
            listen 80 default_server;\\n\\tlocation \/redirect_me \
            {\\n\\treturn 301 https:\\/\\/www.youtube.com\\/watch?v=QH2-TGUlwu4\\n\\t}//' \
            /etc/nginx/sites-enabled/default",
  path     => '/bin',
  provider => shell,
}
