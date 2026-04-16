set shell := ["nu", "-c"]

utils := absolute_path("utils.nu")

default:
    @just --list

# ==== Misc ====

# Build the installer image
[group('nix')]
[linux]
build:
    nix build "./installer#" --log-format bar --rebuild --repair

# Flash the installer image to drive
[group('nix')]
[linux]
flash drive:
    #!/usr/bin/env nu
    use {{ utils }} *;
    flash {{ drive }}
