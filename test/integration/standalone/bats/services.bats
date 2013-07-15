#!/usr/bin/env bats
# vi: set ft=sh :

@test "the apache2 service exists" {
  service apache2 status
}

@test "the mysql service exists" {
  service mysql status
}

@test "php and php5 exist" {
  which php && which php5
}
