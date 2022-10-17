" Vim syntax file for TiddlyWiki
" Language: tiddlywiki
" Last Change: 2009-07-06 Mon 10:15 PM IST
" Maintainer: Devin Weaver <suki@tritarget.org>
" License: http://www.apache.org/licenses/LICENSE-2.0.txt
" Reference: http://tiddlywiki.org/wiki/TiddlyWiki_Markup


""" Initial checks
" To be compatible with Vim 5.8. See `:help 44.12`
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  " Quit when a (custom) syntax file was already loaded
  finish
endif

setlocal isident+=-

""" Patterns
syn spell toplevel

" Rules
syn match twRulesPragma /^\s*\\rules.*$/ contains=twRulesIntent,twRulesValue
syn keyword twRulesIntent except only contained
syn keyword twRulesValue macrodef bold codeinline commentinline dash contained
syn keyword twRulesValue entity extlink filteredtranscludeinline contained
syn keyword twRulesValue hardlinebreaks html image italic macrocallinline contained
syn keyword twRulesValue prettyextlink prettylink strikethrough styleinline contained
syn keyword twRulesValue subscript superscript syslink transcludeinline contained
syn keyword twRulesValue underscore wikilink codeblock commentblock contained
syn keyword twRulesValue filteredtranscludeblock heading horizrule html list contained
syn keyword twRulesValue macrocallblock quoteblock styleblock table contained
syn keyword twRulesValue transcludeblock typedblock contained

" Line matching yoinked from markdown syntax, needed for headings
" This match is super greedy, so set at top so ithers can override later, but:
" TODO: see if this can be simplified
syn match twLineStart "^[<@]\@!" nextgroup=@twBlock
syn cluster twBlock contains=twHeadingH1,twHeadingH2,twHeadingH3,twHeadingH4,twHeadingH5,twHeadingH6

" Heading
syn region twHeadingH1 matchgroup=twH1Delimiter start=" \{,3}!\s"      end="#*\s*$" keepend oneline contains=@Spell contained
syn region twHeadingH2 matchgroup=twH2Delimiter start=" \{,3}!!\s"     end="#*\s*$" keepend oneline contains=@Spell contained
syn region twHeadingH3 matchgroup=twH3Delimiter start=" \{,3}!!!\s"    end="#*\s*$" keepend oneline contains=@Spell contained
syn region twHeadingH4 matchgroup=twH4Delimiter start=" \{,3}!!!!\s"   end="#*\s*$" keepend oneline contains=@Spell contained
syn region twHeadingH5 matchgroup=twH5Delimiter start=" \{,3}!!!!!\s"  end="#*\s*$" keepend oneline contains=@Spell contained
syn region twHeadingH6 matchgroup=twH6Delimiter start=" \{,3}!!!!!!\s" end="#*\s*$" keepend oneline contains=@Spell contained

" Macros
syn region twMacro start=/<<\i\+/ end=/>>/ contains=twStringTriple,twStringDouble,twStringSingle
syn match twMacroDefineStart /^\s*\\define\s\+\i\+(\i*)/ contains=twMacroDefineName
syn match twMacroDefineName /\i\+(\i*)/ contained contains=twMacroDefineArg
syn region twMacroDefineArg start=/(/ms=s+1 end=/)/me=e-1 contained
syn match twMacroDefineEnd /^\s*\\end/
syn match twVariable /\$(\=\i\+)\=\$/

" Widgets
syn region twWidgetStartTag start=/<\$\=\i\+/ end=/>/ contains=twWidgetAttr,twMacro,twTransclude,twStringTriple,twStringDouble,twStringSingle
syn match  twWidgetAttr /\s\i\+=/ contained
syn match  twWidgetEndTag /<\/$\=\i\+>/

" Strings
syn match twStringSingle /'[^']*'/ contained extend contains=@Spell
syn match twStringDouble /"[^"]*"/ contained extend contains=@Spell
syn region twStringTriple start=/"""/ end=/"""/ contained contains=@Spell,@twFormatting
syn match twTransclude /{{[^{}]\{-}}}/

" Link
syn region twLink start=/\[\[/ end=/\]\]/
syn match twCamelCaseLink /[^~]\<[A-Z][a-z0-9]\+[A-Z][[:alnum:]]*\>/
syn match twUrlLink /\<\(https\=\|ftp\|file\):\S*/
syn match twImgLink /\[img.\{-}\[.\{-}\]\]/ contains=twWidgetAttr,twStringTriple,twStringDouble,twStringSingle

" Table
syn match twTable /|/

" Blockquotes
syn match twBlockquote /^>\+.\+$/ contains=@Spell
syn region twBlockquote start=/^<<</ end=/^<<</ contains=@Spell

" Definition list
syn match twDefinitionListTerm /^;.\+$/ contains=@Spell
syn match twDefinitionListDescription /^:.\+$/ contains=@Spell

" Lists
syn match twList /^[\*#]\+/

" Comment
syn region twComment start=/<!--/ end=/-->/ contains=@Spell


" Header Fields
syn match twFieldsLine /^\i\+:\s\+.*$/ contains=twFieldsKey
syn match twFieldsKey /^\i\+:/ contained

" Emphasis
syn match twItalic /\/\/.\{-}\/\// contains=@Spell
syn match twBold /''.\{-}''/ contains=@Spell
syn match twUnderline /__.\{-}__/ contains=@Spell
syn match twStrikethrough /--.\{-}--/ contains=@Spell
syn match twHighlight /@@.\{-}@@/
syn match twNoFormatting /{{{.\{-}}}}/ contains=@Spell
syn match twCode /`[^`]\+`/
syn region twCodeblockTag start=/^```\i*/ end=/^```/ contains=@Spell

""" Clusters
syn cluster twFormatting contains=twTransclude,twLink,twCamelCaseLink,
syn cluster twFormatting add=twUrlLink,twImgLink,twTable,twBlockquote,
syn cluster twFormatting add=twDefinitionListTerm,twDefinitionListDescription,
syn cluster twFormatting add=twHeading,twItalic,twBold,twUnderline,
syn cluster twFormatting add=twStrikethrough,twHighlight,twNoFormatting,
syn cluster twFormatting add=twCode,twCodeblockTag,twComment

""" Highlighting

" Basic Formatting
hi def twItalic term=italic cterm=italic gui=italic
hi def twBold term=bold cterm=bold gui=bold

" Rainbow headers! (requires TokyoNight, but hey, this is my personal setup yo)
hi def twHeadingH1 guifg=#f7768e term=bold cterm=bold gui=bold
hi def twHeadingH2 guifg=#e0af68 term=bold cterm=bold gui=bold
hi def twHeadingH3 guifg=#9ece6a term=bold cterm=bold gui=bold
hi def twHeadingH4 guifg=#1abc9c term=bold cterm=bold gui=bold
hi def twHeadingH5 guifg=#7aa2f7 term=bold cterm=bold gui=bold
hi def twHeadingH6 guifg=#bb9af7 term=bold cterm=bold gui=bold

" With colorful delimiters!
hi def link twH1Delimiter twHeadingDelimiter
hi def link twH2Delimiter twHeadingDelimiter
hi def link twH3Delimiter twHeadingDelimiter
hi def link twH4Delimiter twHeadingDelimiter
hi def link twH5Delimiter twHeadingDelimiter
hi def link twH6Delimiter twHeadingDelimiter
hi def link twHeadingDelimiter Float

" Other stuff
hi def link twUnderline Underlined
hi def link twStrikethrough Ignore
hi def link twHighlight Todo
hi def link twNoFormatting Constant
hi def link twCodeblockTag Constant
hi def link twCode Constant
hi def link twComment Comment
hi def link twList Statement
hi def link twDefinitionListTerm Identifier
hi def link twDefinitionListDescription String
hi def link twBlockquote Repeat
hi def link twTable Label
hi def link twLink Typedef
hi def link twCamelCaseLink Typedef
hi def link twUrlLink Typedef
hi def link twImgLink Typedef
hi def link twTransclude Label
hi def link twWidgetStartTag Structure
hi def link twWidgetAttr Identifier
hi def link twWidgetEndTag Structure
hi def link twStringSingle String
hi def link twStringDouble String
hi def link twStringTriple String
hi def link twFieldsLine String
hi def link twFieldsKey Identifier
hi def link twMacro Label
hi def link twMacroDefineStart Typedef
hi def link twMacroDefineName Label
hi def link twMacroDefineArg Identifier
hi def link twMacroDefineEnd Typedef
hi def link twRulesPragma Typedef
hi def link twRulesIntent Label
hi def link twRulesValue Identifier
hi def link twVariable Identifier
