#!/usr/bin/env bats
# vi: set ft=sh :

@test "/var/www/dvwa/index.php exists" {
  [ -f /var/www/dvwa/index.php ]
}

# REVIEW: Should we redirect index.html?
@test "/var/www/index.html doesn't exist" {
  [ ! -f /var/www/index.html ]
}
