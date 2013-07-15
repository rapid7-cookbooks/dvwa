#!/usr/bin/env bats
# vi: set ft=sh :

@test "/opt/lampp/htdocs/dvwa/index.php exists" {
  [ -f /opt/lampp/htdocs/dvwa/index.php ]
}

# TODO: Add more file tests
