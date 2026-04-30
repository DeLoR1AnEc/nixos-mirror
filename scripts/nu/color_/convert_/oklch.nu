use ../../math_/ 'math atan2'
use ../../math_/ 'math dist'

export def from []: nothing -> record {{
  oklab: { |c: record<L: number, a: number, b: number>|
    {
      L: $c.L
      C: ([$c.a $c.b] | math dist)
      h: (math atan2 $c.a $c.b)
    }
  }
}}