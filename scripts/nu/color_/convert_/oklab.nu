export def from []: nothing -> record {{
  lms: { |c: record<l: number, m: number, s: number>|
    let l_ = $c.l ** (1 / 3) | math round -p 10
    let m_ = $c.m ** (1 / 3) | math round -p 10
    let s_ = $c.s ** (1 / 3) | math round -p 10

    {
      L: (0.2104542553 * $l_ + 0.7936177850 * $m_ - 0.0040720468 * $s_)
      a: (1.9779984951 * $l_ - 2.4285922050 * $m_ + 0.4505937099 * $s_)
      b: (0.0259040371 * $l_ + 0.7827717662 * $m_ - 0.8086757660 * $s_)
    }
  }
  oklch: { |c: record<L: number, C: number, h: number>|
    {
      L: $c.L
      a: ($c.C * ($c.h | math cos))
      b: ($c.C * ($c.h | math sin))
    }
  }
}}