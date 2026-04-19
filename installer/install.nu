#!/usr/bin/env nu

def main [] {
  (gum style
    --foreground 212 --border-foreground 212 --border double
    --align center --width 50 --margin "1 2"
    "NixOS Installer")

  let repo = "https://codeberg.org/DeLoRiAnEc/NixOS.git"
  let flake = "/tmp/config"

  # --- Pick a tag -----------------------------------------------
  (gum style --foreground 212 "Fetching tags...")
  let tags_raw = (git ls-remote --tags --refs $repo | complete)
  if $tags_raw.exit_code != 0 {
    (gum style --foreground 196 $"Error fetching tags: ($tags_raw.stderr)")
    exit 1
  }

  let tags = (
    $tags_raw.stdout
    | lines
    | where { |l| ($l | str trim) != "" }
    | each { |l| $l | split row "\t" | last | str replace "refs/tags/" "" }
  )

  if ($tags | is-empty) {
    (gum style --foreground 196 "No tags found.")
    exit 1
  }

  let tag = (
    $tags
    | str join "\n"
    | gum choose --header "Select tag:"
  )

  # --- Clone ----------------------------------------------------
  (gum style --foreground 212 $"Cloning ($tag)…")
  try { rm -r $flake }
  let clone_raw = (git clone --depth 1 --branch $tag $repo $flake | complete)
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

  # ── Pick a disk ───────────────────────────────────────────────
  let disko_file = $"($flake)/modules/hosts/($host)/_disko.nix"

  (gum style --foreground 99 "Available disks:")
  lsblk -d -o NAME,SIZE,MODEL | grep -v loop

  let disk = (
    lsblk -d -o NAME --noheadings
    | lines
    | where { |l| ($l | str trim) != "" and not ($l | str contains "loop") }
    | each { |l| $"/dev/($l | str trim)" }
    | str join "\n"
    | gum choose --header "Select target disk (ALL DATA WILL BE ERASED):"
  )

  sed -i $"s|device = \"\";|device = \"($disk)\";|" $disko_file

  # ── Facter ────────────────────────────────────────────────────
  let do_facter = try { gum confirm $"Regenerate facter.json for ($host)?"; true } catch { false }
  if $do_facter {
    (gum style --foreground 212 "Generating facter.json…")
    nix run nixpkgs#nixos-facter -- -o $"($flake)/modules/hosts/($host)/facter.json"
  }

  # ── Confirm ───────────────────────────────────────────────────
  let confirmed = try { gum confirm $"Install ($host) from tag '($tag)' onto ($disk)? This will ERASE the disk."; true } catch { false }
  if not $confirmed {
    (gum style --foreground 196 "Aborted.")
    exit 1
  }

  # ── Install ───────────────────────────────────────────────────
  (gum style --foreground 212 $"Installing ($host) onto ($disk)…")

  (gum style --foreground 212 "Running disko…")
  nix run nixpkgs#disko -- --mode disko --flake $"($flake)#($host)"
  sed -i $"s|device = \"($disk)\";|device = \"\";|" $disko_file

  (gum style --foreground 212 "Generating secure boot keys…")
  sbctl create-keys
  chattr -i /sys/firmware/efi/efivars/db-* /sys/firmware/efi/efivars/KEK-*
  try { sbctl enroll-keys --microsoft }

  mkdir /mnt/etc/secureboot/
  cp -r /var/lib/sbctl/keys /mnt/etc/secureboot/keys
  mkdir /mnt/persistent/etc/secureboot/
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