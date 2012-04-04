require 'spec_helper'
require 'fileutils'

describe "Testing the converter" do

  include Rubymine2Xcode

  before :all do
    @ruby_theme = Rubymine2Xcode::RubymineTheme.load_file COBALT_TEST_FILE
    FileUtils.mkpath 'tmp'
    @output_path = "tmp/output.dvtcolortheme"
    FileUtils.remove @output_path if File.exists?(@output_path)
    @converter = Rubymine2Xcode::Converter.new
    @converter.convert @ruby_theme, @output_path
  end

  it "Generates a plist file" do
    File.exist?(@output_path).should be_true
  end

  it "The plist file can be parsed as plist" do
    plist = Plist::parse_xml @output_path
    plist.should_not be_nil
    plist.should be_a(Hash)
  end
end