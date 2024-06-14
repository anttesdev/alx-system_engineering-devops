#login with the holberton user and open a file without any error message

#issue is hardfile and soft file open file limit

exec { 'hard file limit increase':
  provider => shell,
  command  => 'sed -i "s/nofile 5/nofile 50000/" /etc/security/limits.conf',
  path     => '/usr/local/bin/:/bin/'
}

exec { 'soft file limit increase':
  provider => shell,
  command  => 'sed -i "s/nofile 4/nofile 40000/" /etc/security/limits.conf',
  path     => '/usr/local/bin/:/bin/'
}


