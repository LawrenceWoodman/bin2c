package require tcltest
namespace import tcltest::*

set ThisScriptDir [file dirname [info script]]
source [file join $ThisScriptDir test_helpers.tcl]

test bin2c-1 {Outputs to stdout an empty infile} {
  bin2c empty.txt empty
} "unsigned char empty\[\] = {};\nunsigned int empty_len = 0;"

test bin2c-2 {Outputs to stdout an infile containing a single 'a'} {
  bin2c a.txt a_txt
} "unsigned char a_txt\[\] = {\n  0x61\n};\nunsigned int a_txt_len = 1;"

test bin2c-3 {Outputs to stdout an infile containing a 12 bytes} {
  bin2c twelve.txt twelve_txt
} [join [list "unsigned char twelve_txt\[\] = {\n " \
          " 0x61, 0x62, 0x63, 0x64, 0x65, 0x66," \
          " 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c" \
          "\n};\nunsigned int twelve_txt_len = 12;"] \
        ""
  ]

test bin2c-4 {Outputs to stdout an infile containing a 13 bytes} {
  bin2c thirteen.txt thirteen_txt
} [join [list "unsigned char thirteen_txt\[\] = {\n " \
          " 0x61, 0x62, 0x63, 0x64, 0x65, 0x66," \
          " 0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c,\n " \
          " 0x6d" \
          "\n};\nunsigned int thirteen_txt_len = 13;"] \
        ""
  ]

cleanupTests
