#!/usr/bin/env tclsh

# First argument is file to convert, second is optional and is output file.
# If no output file specified, then outputs to stdout
# Could set array name on command line with a switch

if {$argc != 1} {
  puts "Error: wrong number of arguments"
  puts "Usage: bin2c <inputFilename>"
  exit
}
set filename [lindex $argv 0]

set fid [open $filename r]
chan configure $fid -translation binary
set data [read $fid]
close $fid

binary scan $data H* hex
set hex [regsub -all {(..)} $hex {\1 }]
set hex [string trim $hex]
set hex [split $hex]
set dataLength [llength $hex]

set output "unsigned char $filename\[\] = {\n"
for {set i 0} {$i < $dataLength} {incr i} {
  set num [lindex $hex $i]
  append output " 0x$num"
  if {$i != $dataLength-1} {
    append output ","
    if {($i+1) % 12 == 0} {
      append output "\n"
    }
  }
}

append output "\n};\n"
append output "unsigned int " $filename "_len = $dataLength;"

puts $output
