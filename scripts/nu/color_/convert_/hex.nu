use ../../misc_/ 'misc hex'

export def from []: nothing -> record {{
  rgb8: { |c: record<r: int, g: int, b: int>|
    let r = $c.r | misc hex -l 2
    let g = $c.g | misc hex -l 2
    let b = $c.b | misc hex -l 2

    $"#($r)($g)($b)"
  }
}}