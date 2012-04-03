require 'rexml/document'

module Rubymine2Xcode
  # Your code goes here...


  class RubymineTheme
    include REXML

    attr_accessor :colours
    attr_accessor :attributes

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

      instance
    end

  end


end
