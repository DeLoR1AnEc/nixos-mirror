set shell := ["nu", "-c"]

utils := absolute_path("utils.nu")

default:
    @just --list

# ==== Installer ====

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
    use {{ utils }} *
    flash {{ drive }}

# ==== Misc =====

# Print the ansi colors
[linux]
color args="":
    #!/usr/bin/env nu
    use {{ utils }} *
    color {{ args }}
