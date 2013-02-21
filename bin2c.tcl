#!/usr/bin/env tclsh

# First argument is file to convert, second is optional and is output file.
# If no output file specified, then outputs to stdout
# Could set array name on command line with a switch

if {$argc != 2} {
  puts "Error: wrong number of arguments"
  puts "Usage: bin2c <inputFilename> <arrayName>"
  exit
}

proc readBinaryFile {filename} {
  set fid [open $filename r]
  chan configure $fid -translation binary
  set contents [read $fid]
  close $fid
  return $contents
}

proc string2Hex {string} {
  binary scan $string H* hex
  set hex [regsub -all {(..)} $hex {\1 }]
  set hex [string trim $hex]
  return [split $hex]
}


proc bin2c {binaryString arrayName outFid} {
  set hexList [string2Hex $binaryString]
  set hexLength [llength $hexList]
  puts $outFid "unsigned char $arrayName\[\] = {"
  for {set i 0} {$i < $hexLength} {incr i} {
    if {$i % 12 == 0} {puts -nonewline " "}

    set num [lindex $hexList $i]
    puts -nonewline $outFid " 0x$num"

    if {$i != $hexLength-1} {
      puts -nonewline $outFid ","
      if {($i+1) % 12 == 0} {
        puts $outFid ""
      }
    }
  }
  puts $outFid "\n};"
  puts -nonewline $outFid "unsigned int $arrayName"
  puts $outFid "_len = $hexLength;"
}

set inputFilename [lindex $argv 0]
set arrayName [lindex $argv 1]
set inputFileContents [readBinaryFile $inputFilename]
set outFid stdout

bin2c $inputFileContents $arrayName $outFid
