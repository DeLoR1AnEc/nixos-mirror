# --- Helpers ---

# Comutes the cartesian distance
export def dist []: list<float> -> float {
  $in
  | each { |x|
    $x ** 2
  }
  | math sum
  | math sqrt
}

export def atan2 [x: float, y: float] {
  # (($y / ((dist $x $y) + $x)) | math arctan) * 2
}

# --- Color Conversion ---

# HEX - SRGB
export def srgb_to_hex [c: record<r: float, g: float, b: float>] {
  let to_hex = { |x|
    [($x * 255 | math round) 255]
    | math min
    | format number
    | get upperhex
    | str replace "0x" ""
    | fill -a -r -c '0' -w 2
  }
  let r = do $to_hex $c.r
  let g = do $to_hex $c.g
  let b = do $to_hex $c.b
  $"#($r)($g)($b)"
}

export def hex_to_srgb [c: string] {
  $c
  | str replace "#" ""
  | split chars
  | chunks 2
  | each {
    str join
    | into int -r 16
  }
  |
  {
    r: ($in.0 / 255.0 | math round -p 10)
    g: ($in.1 / 255.0 | math round -p 10)
    b: ($in.2 / 255.0 | math round -p 10)
  }
}

# SRGB - OKLAB
export def oklab_to_srgb [c: record<L: float, a: float, b: float>] {
  let l_ = $c.L + 0.3963377774 * $c.a + 0.2158037573 * $c.b
  let m_ = $c.L - 0.1055613458 * $c.a - 0.0638541728 * $c.b;
  let s_ = $c.L - 0.0894841775 * $c.a - 1.2914855480 * $c.b;

  let l = $l_ * $l_ * $l_
  let m = $m_ * $m_ * $m_
  let s = $s_ * $s_ * $s_

  {
    r: (+4.0767416621 * $l - 3.3077115913 * $m + 0.2309699292 * $s),
		g: (-1.2684380046 * $l + 2.6097574011 * $m - 0.3413193965 * $s),
		b: (-0.0041960863 * $l - 0.7034186147 * $m + 1.7076147010 * $s),
  }
}

export def srgb_to_oklab [c: record<r: float, g: float, b: float>] {
  let l = 0.4122214708 * $c.r + 0.5363325363 * $c.g + 0.0514459929 * $c.b;
  let m = 0.2119034982 * $c.r + 0.6806995451 * $c.g + 0.1073969566 * $c.b;
  let s = 0.0883024619 * $c.r + 0.2817188376 * $c.g + 0.6299787005 * $c.b;

  let l_ = $l ** (1 / 3) | math round -p 10
  let m_ = $m ** (1 / 3) | math round -p 10
  let s_ = $s ** (1 / 3) | math round -p 10

  {
   L: (0.2104542553 * $l_ + 0.7936177850 * $m_ - 0.0040720468 * $s_),
   a: (1.9779984951 * $l_ - 2.4285922050 * $m_ + 0.4505937099 * $s_),
   b: (0.0259040371 * $l_ + 0.7827717662 * $m_ - 0.8086757660 * $s_),
  }
}

# OKLAB - OKLCH
export def oklch_to_oklab [c: record<L: float, C: float, h: float>] {

}

export def oklab_to_oklch [c: record<L: float, a: float, b: float>] {
  {
    L: $c.L,
    C: (a ** 2 + b ** 2 | math sqrt),
    h: 1,
  }
}