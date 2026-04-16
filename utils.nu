export def flash [drive: string] {
  let iso = "result/iso/lepton-installer.iso"
  let key_src = "misc/lepton-deploy-key"

  # Validate inputs exist
  if not ($iso | path exists) {
    error make { msg: $"ISO not found: ($iso)" }
  }
  if not ($key_src | path exists) {
    error make { msg: $"Key file not found: ($key_src)" }
  }

  # Write ISO to drive
  print $"Writing ($iso) to ($drive)..."
  dd $"if=($iso)" $"of=/dev/($drive)" bs=4M status=progress oflag=sync,direct

  print "Done."
}