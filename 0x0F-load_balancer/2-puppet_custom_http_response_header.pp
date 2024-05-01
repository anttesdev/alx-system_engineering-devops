#Add a custom header using puppet

exec {'install':
  provider => shell,
  command  => 'sudo apt-get -y update ; sudo apt-get -y install nginx ; echo "Hello World!" > /var/www/html/index.nginx-debian.html ; sudo sed -i "s/server_name _;/server_name _;\n\tadd_header X-Served-By \$hostname;" /etc/nginx/sites-available/default ; sudo service nginx start',
}
