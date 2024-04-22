# Configure the server
include stdlib

# make sure that SSH client configuration refuse to authenticate using a password
file_line { 'Turn off passwd auth':
  path => '/etc/ssh/ssh_config',
  line => 'PasswordAuthentication no',
}

# make sure that SSH client configuration specifies the private key for authentication
file_line { 'Declare identity file':
  path => '/etc/ssh/ssh_config',
  line => 'IdentityFile ~/.ssh/school',
}
