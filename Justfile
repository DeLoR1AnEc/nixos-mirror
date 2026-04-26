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
    nh os switch -a .#{{ host }}
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
    sudo ssh-keygen -t ed25519 -C "{{ host }}" -f /etc/ssh/host
    ssh-keygen -t ed25519 -C "{{ host }}" -f ~/.ssh/host

# ==== Misc =====

# Print the ansi colors
[group('misc')]
color args="":
    color {{ args }}

# Get current power level
[group('misc')]
power:
    cat /sys/class/power_supply/BAT0/capacity
