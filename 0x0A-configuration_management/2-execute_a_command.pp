exec { 'killmenow':
  command     => '/usr/bin/pkill -f killmenow',
  refreshonly => true,
}
