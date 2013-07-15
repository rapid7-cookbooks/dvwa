#!/usr/bin/env bats
# vi: set ft=sh :

@test "the lampp service exists" {
  service lampp status
}

# TODO: Test individual lampp services?
