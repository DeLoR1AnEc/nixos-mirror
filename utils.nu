export def colors [--invert (-i)] {
  # Helper lambdas
  let get_lumi = { |rgb|
    $rgb
    | each { |v|
      if $v <= 10.315 { $v / 3294.6 } else { (0.0037 * $v + 0.052) ** 2.4 }
    }
    | zip [0.299 0.587 0.114]
    | each { $in.0 * $in.1 }
    | math sum
    | math sqrt
  }

  let get_fg = { |rgb, lumi|
    (if $invert { if $lumi > 0.179 { ansi black } else { ansi white } }
      else { ansi -e $"1;38;2;($rgb.0);($rgb.1);($rgb.2)m" })
  }

  let get_bg = { |rgb|
    (if $invert { ansi -e $"1;48;2;($rgb.0);($rgb.1);($rgb.2)m" }
      else { ansi reset })
  }

  let get_hex = { |n|
    printf '%02X' $n | str trim
  }

  let draw = { |rgb, n|
    let lumi = (do $get_lumi $rgb)
    let fg = (do $get_fg $rgb $lumi)
    let bg = (do $get_bg $rgb)
    let hex = (do $get_hex $n)

    $"($bg)($fg)($hex)(ansi reset) "
  }

  # Standart colors
  0..15
  | each { |n|
     do $draw ([
      [  0   0   0], # 0 black
      [128   0   0], # 1 red
      [  0 128   0], # 2 green
      [128 128   0], # 3 yellow
      [  0   0 128], # 4 blue
      [128   0 128], # 5 magenta
      [  0 128 128], # 6 cyan
      [192 192 192], # 7 white
      [128 128 128], # 8 gray
      [255   0   0], # 9 bright red
      [  0 255   0], # A bright green
      [255 255   0], # B bright yellow
      [  0   0 255], # C bright blue
      [255   0 255], # D bright magenta
      [  0 255 255], # E bright cyan
      [255 255 255], # F bright white
    ] | get $n) $n
  }
  | str join
  | print

  print "\n"

  # RGB cube
  0..5 | each { |b|
    0..5 | each { |r|
      0..5 | each { |g|
        let n = 16 + (36 * $r + 6 * $g + $b)
        let c = { |v| if $v == 0 { 0 } else { 40 * $v + 55 } }
        do $draw (
          [(do $c $r) (do $c $g) (do $c $b)]
        ) $n
      }
      | str join
    }
    | str join "  "
  }
  | str join "\n"
  | print

  print "\n"

  # Gray spectrum
  232..255
  | each { |n|
    let v = 10 * ($n - 232) + 8
    do $draw [$v $v $v] $n
  }
  | str join
  | print
}