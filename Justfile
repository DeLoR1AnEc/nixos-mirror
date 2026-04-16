set shell := ["nu", "-c"]

utils := absolute_path("utils.nu")

default:
    @just --list

# ==== Misc ====

# Displays the terminal color codes
[linux]
colors *args="":
    #!/usr/bin/env nu
    use {{ utils }} *;
    colors {{ args }}
