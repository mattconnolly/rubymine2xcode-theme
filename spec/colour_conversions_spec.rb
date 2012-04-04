require 'spec_helper'

include Rubymine2Xcode::ColourConversion

describe "Colour conversions" do

  it "Converts hex strings to array or rgb values in range 0..1" do

    array = rubymine_colour_to_a "ffffff"
    array.should == [1.0, 1.0, 1.0]

    array = rubymine_colour_to_a "000000"
    array.should == [0, 0, 0]

    array = rubymine_colour_to_a "4080c0"
    array.should == [0x40/255.0, 0x80/255.0, 0xc0/255.0]

    array = rubymine_colour_to_a "48c"
    array.should == [0x00/255.0, 0x04/255.0, 0x8c/255.0]

    array = rubymine_colour_to_a "48c0"
    array.should == [0x00/255.0, 0x48/255.0, 0xc0/255.0]
  end


end
