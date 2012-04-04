require 'rexml/document'

module Rubymine2Xcode
  # Your code goes here...


  class RubymineTheme
    include REXML

    attr_accessor :colours
    attr_accessor :attributes
    attr_accessor :font_name, :font_size

    def initialize()
      @colours = []
      @attributes = {}
    end

    def colour_named(name)
      result = @colours.find { |colour| colour[:name] == name }
      result[:value] unless result.nil?
    end

    def self.load_file(filename)
      instance = self.new

      xmlfile = File.new(filename)
      xmldoc = Document.new(xmlfile)

      # Now get the root element
      root = xmldoc.root

      # set colours
      root.elements.each("colors/option") do |element|
        name = element.attributes["name"]
        value = element.attributes["value"]
        instance.colours << { :name => name, :value => value }
      end


      # read attributes
      root.elements.each("attributes/option") do |element|
        name = element.attributes["name"]
        attr = {}
        element.elements.each("value/option") do |value_element|
          value_name = value_element.attributes["name"]
          value_value = value_element.attributes["value"]
          attr[value_name] = value_value
        end
        instance.attributes[name] = attr
      end


      # read font name and size
      instance.font_name = XPath.first(xmldoc, '/scheme/option[@name="EDITOR_FONT_NAME"]').attribute("value").value
      instance.font_size = XPath.first(xmldoc, '/scheme/option[@name="EDITOR_FONT_SIZE"]').attribute("value").value.to_i

      instance
    end


  end


  module ColourConversion

    def rubymine_colour_to_a string
      # rubymine colours have leading zeros stripped
      string = "0" * (6 - string.length) + string if string.length < 6
      red = string[0..1]
      green = string[2..3]
      blue = string[4..5]
      [red.to_i(16)/255.0, green.to_i(16)/255.0, blue.to_i(16)/255.0]
    end

  end


end

