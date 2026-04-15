#!/usr/bin/env nu

def main [] {
  (gum style
    --foreground 212 --border-foreground 212 --border double
    --align center --width 50 --margin "1 2"
    "NixOS Installer")

  let repo = "https://codeberg.org/DeLoRiAnEc/NixOS"
  let config = "/etc/nixos/"

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
    | each { |l| $l | splitr row "\t" | last | str replace "refs/tags/" "" }
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
  (gum style --foreground 212 $"Cloning ($tag)...")
  try { rm -r $config }
  let clone = (git clone --depth 1 --branch $tag $repo $config | complete)
  if $clone.exit_code != 0 {
    (gum style --foreground 196 $"Error cloning repo: ($clone.stderr)")
    exit 1
  }

  # --- Pick a host ----------------------------------------------
  let hosts = (ls ../modules/hosts/)
  let host = (
    $hosts
    | gum choose --header "Select host to install:"
  )
}