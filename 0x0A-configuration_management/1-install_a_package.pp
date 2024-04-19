# Install flask version 2.1.0

package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}

# Install Werkzeug version 2.1.1
package { 'Werkzeug':
  ensure   => '2.1.1',
  provider => 'pip3',
}
