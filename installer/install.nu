#!/usr/bin/env nu

def main [] {
  (gum style
    --foreground 212 --border-foreground 212 --border double
    --align center --width 50 --margin "1 2"
    "NixOS Installer")

  let repo = "https://codeberg.org/DeLoRiAnEc/NixOS.git"
  let flake = "/tmp/config"

  # --- Pick a branch --------------------------------------------
  (gum style --foreground 212 "Fetching tags...")
  let branches_raw = (git ls-remote --heads $repo | complete)
  if $branches_raw.exit_code != 0 {
    (gum style --foreground 196 $"Error fetching tags: ($branches_raw.stderr)")
    exit 1
  }

  let branches = (
    $branches_raw.stdout
    | lines
    | where { |l| ($l | str trim) != "" }
    | each { |l| $l | split row "\t" | last | str replace "refs/heads/" "" }
  )

  if ($branches | is-empty) {
    (gum style --foreground 196 "No tags found.")
    exit 1
  }

  let branch = (
    $branches
    | str join "\n"
    | gum choose --header "Select tag:"
  )

  # --- Clone ----------------------------------------------------
  (gum style --foreground 212 $"Cloning ($branch)…")
  try { rm -r $flake }
  let clone_raw = (git clone --depth 1 --branch $branch $repo $flake | complete)
  if $clone_raw.exit_code != 0 {
    (gum style --foreground 196 $"Error cloning repo: ($clone_raw.stderr)")
    exit 1
  }

  # ── Pick a host ───────────────────────────────────────────────
  let hosts_raw = (nix flake show --json --no-write-lock-file $flake | complete)
  if $hosts_raw.exit_code != 0 {
    (gum style --foreground 196 $"Error reading flake: ($hosts_raw.stderr)")
    exit 1
  }

  let host = (
    $hosts_raw.stdout
    | from json
    | get nixosConfigurations
    | columns
    | str join "\n"
    | gum choose --header "Select host to install:"
  )

  # ── Facter ────────────────────────────────────────────────────
  let do_facter = try { gum confirm $"Regenerate facter.json for ($host)?"; true } catch { false }
  if $do_facter {
    (gum style --foreground 212 "Generating facter.json…")
    nix run nixpkgs#nixos-facter -- -o $"($flake)/modules/hosts/($host)/facter.json"
  }

  # ── Confirm ───────────────────────────────────────────────────
  let confirmed = try { gum confirm $"Install ($host) from branch '($branch)'? This will ERASE the disk."; true } catch { false }
  if not $confirmed {
    (gum style --foreground 196 "Aborted.")
    exit 1
  }

  # ── Install ───────────────────────────────────────────────────
  (gum style --foreground 212 $"Installing ($host)…")

  (gum style --foreground 212 "Running disko…")
  nix run nixpkgs#disko -- --mode disko --flake $"($flake)#($host)"

  (gum style --foreground 212 "Generating secure boot keys…")
  sbctl create-keys
  chattr -i /sys/firmware/efi/efivars/db-* /sys/firmware/efi/efivars/KEK-*
  try { sbctl enroll-keys --microsoft }

  mkdir -p /mnt/etc/secureboot/
  cp -r /var/lib/sbctl/keys /mnt/etc/secureboot/keys
  mkdir -p /mnt/persistent/etc/secureboot/
  cp -r /var/lib/sbctl/keys /mnt/persistent/etc/secureboot/keys

  (gum style --foreground 212 "Running nixos-install…")
  nixos-install --flake $"($flake)#($host)" --no-root-passwd
  bootctl install --esp-path=/mnt/boot

  (gum style --foreground 212 "Copying flake to target…")
  cp -r $flake /mnt/persistent/

  (gum style
    --foreground 46 --border-foreground 46 --border rounded
    --align center --width 50 --margin "1 2"
    "Done! Remove the USB and reboot.")
}