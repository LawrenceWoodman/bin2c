# Helper functions for the tests

namespace eval TestHelpers {
  variable ThisScriptDir [file dirname [info script]]
  variable BinDir [file normalize [file join $ThisScriptDir ..]]
  variable FixturesDir [file normalize [file join $ThisScriptDir fixtures]]
  variable Bin2CTcl [file join $BinDir bin2c.tcl]

  # Run the bin2c.tcl script with a fixture
  proc bin2c {fixtureFilename arrayName args} {
    variable FixturesDir
    variable Bin2CTcl
    set fullFixtureFilename [file join $FixturesDir $fixtureFilename]
    return [exec tclsh $Bin2CTcl $fullFixtureFilename $arrayName]
  }

  namespace export bin2c
}

namespace import TestHelpers::*
