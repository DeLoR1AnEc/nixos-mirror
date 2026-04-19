export def flash [drive: string] {
  let iso = "result/iso/installer.iso"

  if not ($iso | path exists) {
    error make { msg: $"ISO not found: ($iso)" }
  }

  # Write ISO to drive
  print $"Writing ($iso) to ($drive)..."
  dd $"if=($iso)" $"of=/dev/($drive)" bs=4M status=progress oflag=sync,direct

  print "Done."
}

export def color [--invert (-i)] {
  let to_hex = { |n: int|
    $n
    | format number
    | get upperhex
    | str replace "0x" ""
    | fill -a r -c '0' -w 2
  }

  let print_color = { |id: int, bg: bool|
    let hex = (do $to_hex $id)
    print -n (
      if not $bg {
        ansi -e $"1;38;5;($id)m($hex)(ansi reset) "
      } else {
        ansi -e $"1;48;5;($id)m($hex)(ansi reset) "
      }
    ) | ignore
  }

  0..7
  | each { |n| do $print_color $n $invert }
  print ""

  8..15
  | each { |n| do $print_color $n $invert }
  print "\n"

  0..5 | each { |r|
    0..5 | each { |g|
      0..5 | each { |b|
        do $print_color (16 + 36 * $r + 6 * $g + $b) $invert
      }; print -n "  "
    }; print ""
  }; print ""

  232..255
  | each { |n| do $print_color $n $invert }
  print ""
}