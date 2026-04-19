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

export def follow [] {
  let get_base = { |s| $s | str replace -r '_\d+$' '' }
  let lock = open flake.lock | from json

  let new_nodes = $lock.nodes
    | transpose name val
    | reduce -f {} { |node, acc|
      if $node.name != (do $get_base $node.name) { return $acc }

      let inputs = $node.val.inputs?
        | default {}
        | transpose k v
        | update v { |i|
          if ($i.v | describe | str starts-with "list") {
            $i.v | last | do $get_base $in
          } else {
            do $get_base $i.v
          }
        }
        | transpose -r -d

      let val = if ($inputs | is-empty) {
        $node.val | reject inputs?
      } else {
        $node.val | upsert inputs $inputs
      }

      $acc | insert $node.name $val
    }

  $lock
  | update nodes $new_nodes
  | to json --indent 2
  | save --force flake.lock
}