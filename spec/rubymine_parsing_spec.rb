require 'spec_helper'

COBALT_TEST_FILE = File.expand_path("files/cobalt2.xml", File.dirname(__FILE__))

describe "Parsing Rubymine XML file" do


  before :each do

    @r2x = Rubymine2Xcode::RubymineTheme.load_file COBALT_TEST_FILE
  end


  it "builds an Array of colours" do
    @r2x.colours.should be_an(Array)
    @r2x.colours.should_not be_empty
  end

  it "can access colours by index" do
    @r2x.colours[0].should == { :name => "CARET_COLOR", :value => "ffffff" }
  end

  it "can access colours by name" do
    @r2x.colour_named("CARET_ROW_COLOR").should == "1629"
  end

end
