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

# Converts npins sources into a human readable format
[group('nix')]
[linux]
@sources input="":
    open lon/lock.json | get sources {{ if input != "" { "| get " + input } else { "" } }}

[group('nix')]
[linux]
build:
    nix-build -A flake.nixosConfigurations.electron.config.system.build.toplevel --show-trace o+e>|
