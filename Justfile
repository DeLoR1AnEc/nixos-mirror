set shell := ["nu", "--env-config", "./utils.nu", "-c"]
set quiet := true

default:
    just --list

# ==== Nix ====

# Update inputs
[group('nix')]
[linux]
update:
    nix flake update
    follow

# ==== Install ====

# Build the installer image
[group('install')]
[linux]
build:
    nix build "./installer#" --log-format bar --rebuild --repair

# Flash the installer image to drive
[group('install')]
[linux]
flash drive:
    flash {{ drive }}

# ==== Misc =====

# Print the ansi colors
[linux]
color args="":
    color {{ args }}
