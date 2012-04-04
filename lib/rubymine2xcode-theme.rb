require "rubymine2xcode-theme/version"
require "rubymine2xcode-theme/rubymine"
require "rubymine2xcode-theme/xcode"
require 'plist'


module Rubymine2Xcode
  # Your code goes here...

  class Converter

    include ColourConversion

    COLOUR_CONVERSIONS = %w{

      DVTConsoleDebuggerInputTextColor        attributes/CONSOLE_USER_INPUT
      DVTConsoleDebuggerOutputTextColor       attributes/CONSOLE_NORMAL_OUTPUT
      DVTConsoleDebuggerPromptTextColor       attributes/CONSOLE_GRAY_OUTPUT
      DVTConsoleExectuableInputTextColor      attributes/CONSOLE_USER_INPUT
      DVTConsoleExectuableOutputTextColor     attributes/CONSOLE_NORMAL_OUTPUT

      DVTConsoleTextBackgroundColor           colours/CONSOLE_BACKGROUND_KEY
      DVTConsoleTextInsertionPointColor       colours/CARET_ROW_COLOR
      DVTConsoleTextSelectionColor            colours/SELECTION_BACKGROUND
      DVTDebuggerInstructionPointerColor      attributes/BAD_CHARACTER/BACKGROUND
      DVTSourceTextBackground                 colours/CONSOLE_BACKGROUND_KEY
      DVTSourceTextBlockDimBackgroundColor    attributes/RUBY_HEREDOC_CONTENT/BACKGROUND
      DVTSourceTextInsertionPointColor        colours/CARET_COLOR
      DVTSourceTextInvisiblesColor            colours/WHITESPACES
      DVTSourceTextSelectionColor             colours/SELECTION_BACKGROUND

      DVTSourceTextSyntaxColors/xcode.syntax.attribute    attributes/RUBY_IVAR
      DVTSourceTextSyntaxColors/xcode.syntax.character    attributes/RUBY_SYMBOL
      DVTSourceTextSyntaxColors/xcode.syntax.comment      attributes/RUBY_COMMENT
      DVTSourceTextSyntaxColors/xcode.syntax.comment.doc      attributes/JAVA_DOC_COMMENT
      DVTSourceTextSyntaxColors/xcode.syntax.comment.doc.keyword    attributes/JAVA_DOC_COMMENT
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.class           attributes/RUBY_CONSTANT
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.class.system    attributes/RUBY_CONSTANT
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.constant          attributes/RUBY_CONSTANT_DECLARATION
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.constant.system   attributes/RUBY_CONSTANT_DECLARATION
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.function          attributes/RUBY_METHOD_NAME
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.function.system   attributes/RUBY_METHOD_NAME
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.macro             attributes/RUBY_SPECIFIC_CALL
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.macro.system      attributes/RUBY_SPECIFIC_CALL
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.type              attributes/RUBY_REGEXP
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.type.system       attributes/RUBY_REGEXP
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.variable          attributes/RUBY_IVAR
      DVTSourceTextSyntaxColors/xcode.syntax.identifier.variable.system   attributes/RUBY_IVAR
      DVTSourceTextSyntaxColors/xcode.syntax.keyword        attributes/RUBY_KEYWORD
      DVTSourceTextSyntaxColors/xcode.syntax.number         attributes/RUBY_NUMBER
      DVTSourceTextSyntaxColors/xcode.syntax.plain          attributes/RUBY_IDENTIFIER
      DVTSourceTextSyntaxColors/xcode.syntax.preprocessor   attributes/RUBY_SPECIFIC_CALL
      DVTSourceTextSyntaxColors/xcode.syntax.string         attributes/RUBY_STRING
      DVTSourceTextSyntaxColors/xcode.syntax.url            attributes/HYPERLINK_ATTRIBUTES

    }

    FONT_CONVERSIONS = %w{
      DVTConsoleDebuggerInputTextFont
      DVTConsoleDebuggerOutputTextFont
      DVTConsoleDebuggerPromptTextFont
      DVTConsoleExectuableInputTextFont
      DVTConsoleExectuableOutputTextFont

      DVTSourceTextSyntaxFonts/xcode.syntax.attribute
      DVTSourceTextSyntaxFonts/xcode.syntax.character
      DVTSourceTextSyntaxFonts/xcode.syntax.comment
      DVTSourceTextSyntaxFonts/xcode.syntax.comment.doc
      DVTSourceTextSyntaxFonts/xcode.syntax.comment.doc.keyword
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.class
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.class.system
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.constant
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.constant.system
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.function
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.function.system
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.macro
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.macro.system
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.type
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.type.system
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.variable
      DVTSourceTextSyntaxFonts/xcode.syntax.identifier.variable.system
      DVTSourceTextSyntaxFonts/xcode.syntax.keyword
      DVTSourceTextSyntaxFonts/xcode.syntax.number
      DVTSourceTextSyntaxFonts/xcode.syntax.plain
      DVTSourceTextSyntaxFonts/xcode.syntax.preprocessor
      DVTSourceTextSyntaxFonts/xcode.syntax.string
      DVTSourceTextSyntaxFonts/xcode.syntax.url
    }



    def convert(rubymine_theme, output_filename)
      output = {}

      COLOUR_CONVERSIONS.each_slice(2) do |slice|

        #prepare the destination
        destination = slice[0]
        destination_split = destination.split '/'
        if destination_split.length == 1
          destination_hash = output
        else
          output[destination_split[0]] ||= {}
          destination_hash = output[destination_split[0]]
          destination = destination_split[1]
        end


        #read the colour
        method, name, property = slice[1].split '/'
        property ||= 'FOREGROUND'
        colour = case method
                   when 'colours'
                     rubymine_theme.colour_named name
                   when 'attributes'
                     rubymine_theme.attributes[name][property]
                   else
                     nil
                 end

        puts "WARNING: #{slice[1]} was not found in rubymine theme!" unless colour

        colour ||= "808080"

        #convert to Xcode colour
        colour = rubymine_colour_to_a(colour)
        colour << 1

        destination_hash[destination] = colour.join(' ')
      end


      # Define the fonts
      font = "#{rubymine_theme.font_name} - #{rubymine_theme.font_size}"
      FONT_CONVERSIONS.each do |item|

        #prepare the destination
        destination = item
        destination_split = destination.split '/'
        if destination_split.length == 1
          destination_hash = output
        else
          output[destination_split[0]] ||= {}
          destination_hash = output[destination_split[0]]
          destination = destination_split[1]
        end

        destination_hash[destination] = font
      end

      # save output file
      File.open(output_filename, "w") do |file|
        file << output.to_plist
      end

    end
  end
end
