# Different stuff that i dont want to organize
export def misc [] { help misc }

# Convert a number into a hex with a specified length
export def 'misc hex' [
  --length(-l)=1
]: int -> string {
  format number
  | get upperhex
  | str replace '0x' ''
  | fill -a 'r' -c '0' -w $length
}

# Prints all the fields of a record with a specified message
export def 'misc list-record' [
  msg: string,
]: record -> nothing {
  print $"(ansi g)($msg):"
  $in
  | columns
  | each { |t|
    print $"(ansi c)-> ($t)"
  } | ignore
}