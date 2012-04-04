require 'spec_helper'


describe "Parsing Rubymine XML file" do


  before :all do
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

  it "builds an Hash of attributes" do
    @r2x.attributes.should be_a(Hash)
    @r2x.attributes.should_not be_empty
  end

  it "each attribute hash has a hash of values" do
    @r2x.attributes.each_pair do |name, values|
      values.should be_a(Hash)
      values.should_not be_empty
    end
  end

  it "gets the font name and size" do
    @r2x.font_name.should == "Monaco"
    @r2x.font_size.should == 12
  end

  it "print a list of attribute names" do
    @r2x.attributes.each do |attr|
      attr[0].should_not be_nil
    end
  end

end
