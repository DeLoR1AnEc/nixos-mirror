export def from []: nothing -> record {{
  lms: { |c: record<l: number, m: number, s: number>|
    {
      r: (+4.0767416621 * $c.l - 3.3077115913 * $c.m + 0.2309699292 * $c.s)
      g: (-1.2684380046 * $c.l + 2.6097574011 * $c.m - 0.3413193965 * $c.s)
      b: (-0.0041960863 * $c.l - 0.7034186147 * $c.m + 1.7076147010 * $c.s)
    }
  },
  rgb8: { |c: record<r: int, g: int, b: int>|
    {
      r: ($c.r / 255 | math round -p 10)
      g: ($c.g / 255 | math round -p 10)
      b: ($c.b / 255 | math round -p 10)
    }
  }
}}