# kills a process killmenow

exec { 'killmenow':
  path    => 'usr/bin/',
  command     => 'pkill killmenow',
  provider   => 'shell',
}
