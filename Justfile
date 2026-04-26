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

# Rebuild and switch config
[group('nix')]
[linux]
switch host:
    nixos-rebuild switch --flake .#{{ host }}

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
[group('misc')]
[linux]
color args="":
    color {{ args }}
