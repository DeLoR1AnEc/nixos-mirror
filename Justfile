set shell := ["nu", "--env-config", "./utils.nu", "-c"]

default:
    just --list

# ==== Nix ====

# Update inputs
[group('nix')]
update:
    nix flake update

# Rebuild and switch config
[group('nix')]
[no-cd]
switch host:
    sudo nixos-rebuild switch --flake .#{{ host }}
    activate

# ==== Install ====

# Build the installer image
[group('install')]
build:
    nix build "./installer#" --log-format bar --rebuild --repair

# Flash the installer image to drive
[group('install')]
flash drive:
    flash {{ drive }}

# Generate an ssh key
[group('install')]
ssh-generate host:
    ssh-keygen -t ed25519 -C "{{ host }}" -f /etc/ssh/{{ host }}

# ==== Misc =====

# Print the ansi colors
[group('misc')]
color args="":
    color {{ args }}
