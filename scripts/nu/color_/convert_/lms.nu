export def from []: nothing -> record {{
  srgb: { |c: record<r: number, g: number, b: number>|
    {
      l: (0.4122214708 * $c.r + 0.5363325363 * $c.g + 0.0514459929 * $c.b)
      m: (0.2119034982 * $c.r + 0.6806995451 * $c.g + 0.1073969566 * $c.b)
      s: (0.0883024619 * $c.r + 0.2817188376 * $c.g + 0.6299787005 * $c.b)
    }
  }
  oklab: { |c: record<L: number, a: number, b: number>|
    let l_ = $c.L + 0.3963377774 * $c.a + 0.2158037573 * $c.b
    let m_ = $c.L - 0.1055613458 * $c.a - 0.0638541728 * $c.b
    let s_ = $c.L - 0.0894841775 * $c.a - 1.2914855480 * $c.b

    {
      l: ($l_ * $l_ * $l_)
      m: ($m_ * $m_ * $m_)
      s: ($s_ * $s_ * $s_)
    }
  }
}}