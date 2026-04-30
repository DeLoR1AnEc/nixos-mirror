# Color

## Convert
Responsible for converting from one color format to another

```
Converts from one color format to another

Usage:
  > color convert {flags} (from) (to)

Flags:
  -h, --help: Display the help message for this command
  -l, --list: List all allowed formats
  -s, --show: Show the conversion path

Command Type:
  > custom

Parameters:
  from <string>: Format from which to convert (optional)
  to <string>: Format to which to convert (optional)

Input/output types:
  ╭───┬───────┬────────╮
  │ # │ input │ output │
  ├───┼───────┼────────┤
  │ 0 │ any   │ record │
  ╰───┴───────┴────────╯

Examples:
  Convert from hex to oklab and show the conversion path
  > "#4D1FF7" | color convert -s hex oklab
  Conversion path:
  hex -> rgb8 -> srgb -> lms -> oklab
  ╭───┬───────╮
  │ L │ 0.63  │
  │ a │ 0.09  │
  │ b │ -0.20 │
  ╰───┴───────╯
```

## Travel
Allows