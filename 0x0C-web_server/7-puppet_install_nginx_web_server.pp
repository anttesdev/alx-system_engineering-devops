# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure => 'running',
  enable => true,
  require => Package['nginx'],
}

# Define the redirection using sed
exec { 'configure_redirect':
  command     => "/bin/sed -i 's/server_name _;/server_name _;\\n\\trewrite ^\\/redirect_me https:\\/\\/www.youtube.com\\/watch?v=QH2-TGUlwu4 permanent;/' /etc/nginx/sites-enabled/default",
  path        => '/bin',
  refreshonly => true,
  subscribe   => Package['nginx'],
  notify      => Service['nginx'],
}
