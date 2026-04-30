use hex.nu
use lms.nu
use oklab.nu
use oklch.nu
use rgb8.nu
use srgb.nu

use ../../misc_/ 'misc list-record'

def build-graph []: nothing -> record {
  {
    hex:   (hex   from)
    lms:   (lms   from)
    oklab: (oklab from)
    oklch: (oklch from)
    rgb8:  (rgb8  from)
    srgb:  (srgb  from)
  }
}

def find-path [from: string, to: string]: record -> list<string> {
  let graph = $in

  mut visited = [$from]
  mut queue = [[$from]]

  return (loop {
    if ($queue | is-empty) {
      error make { msg: $"no conversion path from '($from)' to '($to)'" }
    }

    let path = $queue | first
    $queue = $queue | skip 1

    let node = $path | last
    if $node == $to { return $path }

    let neighbors = $graph | get $node | columns
    for neighbor in $neighbors {
      if $neighbor not-in $visited {
        $queue = $queue | append [($path | append $neighbor)]
        $visited = $visited | append $neighbor
      }
    }
  })
}

# Converts from one color format to another
@example "Convert from hex to oklab and show the conversion path" {"#4D1FF7" | color convert -s hex oklab} --result $"
(ansi g)Conversion path:
(ansi c)hex -> rgb8 -> srgb -> lms -> oklab(ansi reset)
╭───┬───────╮
│ L │ 0.63  │
│ a │ 0.09  │
│ b │ -0.20 │
╰───┴───────╯
"
export def 'color convert' [
  from?: string, # Format from which to convert
  to?: string,   # Format to which to convert
  --list (-l),   # List all allowed formats
  --show (-s)    # Show the conversion path
]: any -> record {
  let value = $in
  let graph = build-graph

  if $list {
    $graph | misc list-record "Allowed formats"
    return
  }

  if $from not-in ($graph | columns) {
    error make { msg: $"unknown type '($from)', use --list to see allowed types" }
  }

  if $to not-in ($graph | columns) {
    error make { msg: $"unknown type '($to)', use --list to see allowed types" }
  }

  if $value == null {
    error make { msg: $"requires a value as pipeline input" }
  }

  let path = $graph | find-path $from $to

  if $show {
    print $"(ansi g)Conversion path:"
    $path
    | enumerate
    | each { |it|
      mut s = ""
      if $it.index == 0 {
        $s = $"($it.item)"
      } else {
        $s = $" -> ($it.item)"
      }

      print -n $"(ansi c)($s)"
    } | ignore
    print ""
  }

  mut result = $value
  for i in 0..(($path | length) - 2) {
    let src = $path | get $i
    let dst = $path | get ($i + 1)
    $result = do ($graph | get $dst | get $src) $result
  }

  $result
}