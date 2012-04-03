#!/usr/bin/env ruby
#
# rubymine2xcode-theme
#
# This program converts a rubymine colour theme into an xcode theme
#


require 'rexml/document'
include REXML

xmlfile = File.new("cobalt2.xml")
xmldoc = Document.new(xmlfile)


