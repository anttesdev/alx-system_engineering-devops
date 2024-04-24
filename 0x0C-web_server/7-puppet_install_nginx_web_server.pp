# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

exec { 'install nginx':
  command => 'sudo apt-get update ; sudo apt-get -y install nginx',
  provider => shell,
  require => Package['nginx'],
}

exec { 'configure_redirect':
  command => "/bin/sed -i 's/listen 80 default_server;/ \
            listen 80 default_server;\\n\\trewrite ^\\/redirect_me \
            https:\\/\\/www.youtube.com\\/watch?v=QH2-TGUlwu4 permanent;/' \
            /etc/nginx/sites-enabled/default",
  path        => '/bin',
  provider    => shell,
}
