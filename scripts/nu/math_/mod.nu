# Returns the cartesian distance of a list of numbers from 0
export def 'math dist' []: list<number> -> number {
  each { |x| $x ** 2 }
  | math sum
  | math sqrt
}

# Returns the atan2 of 2 numbers
export def 'math atan2' [
  x: number,
  y: number
]: nothing -> number {
  if $y == 0 { return 0 }
  2 * ($y / (([$x $y] | math dist) + $x) | math arctan)
}