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

# Configure redirection
exec { 'configure_redirect':
  command  => "/bin/sed -i 's/listen 80 default_server;/listen 80 default_server;\\n    location \\/redirect_me {\\n        return 301 https:\\/\\/www.youtube.com\\/watch?v=QH2-TGUlwu4;\\n    }\\n\\t/' /etc/nginx/sites-enabled/default",
  path     => '/bin',
  provider => shell,
}
