use ../../misc_/ 'misc hex'

export def from []: nothing -> record {{
  srgb: { |c: record<r: number, g: number, b: number>|
    {
      r: ($c.r * 255 | math round)
      g: ($c.g * 255 | math round)
      b: ($c.b * 255 | math round)
    }
  },
  hex: { |c: string|
    $c
    | str replace '#' ''
    | split chars
    | chunks 2
    | each { str join | into int -r 16 }
    |
    {
      r: ($in.0)
      g: ($in.1)
      b: ($in.2)
    }
  }
}}
