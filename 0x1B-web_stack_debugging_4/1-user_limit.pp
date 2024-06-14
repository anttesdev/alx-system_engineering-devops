#login with the holberton user and open a file without any error message

#issue is hardfile and soft file open file limit
exec { 'hard file limit increase':
  command  => 'sed -i "/holberton hard/s/5/50000/" /etc/security/limits.conf',
  path     => '/usr/local/bin/:/bin/'
  provider => shell,
}

exec { 'soft file limit increase':
  command  => 'sed -i "/holberton soft/s/4/50000/" /etc/security/limits.conf',
  path     => '/usr/local/bin/:/bin/'
  provider => shell,
}


