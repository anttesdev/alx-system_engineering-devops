# fixing a 500 server fix in apache2
exec { 'fix apache':
  command => "sed -i 's/phpp/php/g' /var/www/html/wp-settings.php",
  path    => '/bin';
}
