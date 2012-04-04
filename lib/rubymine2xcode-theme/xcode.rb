module Rubymine2Xcode
  # Your code goes here...



  class XcodeTheme

  end

  # these ones exist in the root of the plist file
  XCODE_STYLES_1 = %w{
    DVTConsoleDebuggerInputTextColor
    DVTConsoleDebuggerInputTextFont
    DVTConsoleDebuggerOutputTextColor
    DVTConsoleDebuggerOutputTextFont
    DVTConsoleDebuggerPromptTextColor
    DVTConsoleDebuggerPromptTextFont
    DVTConsoleExectuableInputTextColor
    DVTConsoleExectuableInputTextFont
    DVTConsoleExectuableOutputTextColor
    DVTConsoleExectuableOutputTextFont
    DVTConsoleTextBackgroundColor
    DVTConsoleTextInsertionPointColor
    DVTConsoleTextSelectionColor
    DVTDebuggerInstructionPointerColor
    DVTSourceTextBackground
    DVTSourceTextBlockDimBackgroundColor
    DVTSourceTextInsertionPointColor
    DVTSourceTextInvisiblesColor
    DVTSourceTextSelectionColor
    DVTSourceTextSyntaxColors
    DVTSourceTextSyntaxFonts
  }

  # these ones have a colour entry under 'DVTSourceTextSyntaxColors'
  # and a font entry under 'DVTSourceTextSyntaxFonts'
  XCODE_STYLES_2 = %w{
    xcode.syntax.attribute
    xcode.syntax.character
    xcode.syntax.comment
    xcode.syntax.comment.doc
    xcode.syntax.comment.doc.keyword
    xcode.syntax.identifier.class
    xcode.syntax.identifier.class.system
    xcode.syntax.identifier.constant
    xcode.syntax.identifier.constant.system
    xcode.syntax.identifier.function
    xcode.syntax.identifier.function.system
    xcode.syntax.identifier.macro
    xcode.syntax.identifier.macro.system
    xcode.syntax.identifier.type
    xcode.syntax.identifier.type.system
    xcode.syntax.identifier.variable
    xcode.syntax.identifier.variable.system
    xcode.syntax.keyword
    xcode.syntax.number
    xcode.syntax.plain
    xcode.syntax.preprocessor
    xcode.syntax.string
    xcode.syntax.url
  }



end
