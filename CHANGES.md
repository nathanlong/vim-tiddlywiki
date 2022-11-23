## Change Overview

* General
  * Removed `created` and `modifier` fields on tiddler initialization (a single-user wiki does not generate them)
* Journal
  * Allow setting journal tags through configuration
  * Add date manipulation and commands to open today, tomorrow, and yesterday's journal entries (and commands to invoke)
* Syntax
  * 🌈 RAINBOW HEADERS (currently requires [TokyoNight](https://github.com/folke/tokyonight.nvim))
  * Slightly better colors for dark theme usage

## Modified Commands

* `TiddlyWikiEditJournal` : Open the journal tiddler for today or create it if it doesn't exist
  * Now accepts a string to pass to the `date` utility, such as `+1d` for one day past today's date. See `date` for more info on formats.

## New Mappings

```vimscript
nmap <Leader>tj :TiddlyWikiEditJournal<space>+0d<Cr>
nmap <Leader>tJ :vsplit<cr>:TiddlyWikiEditJournal<space>+0d<Cr>
nmap <Leader>tk :TiddlyWikiEditJournal<space>+1d<Cr>
nmap <Leader>tK :TiddlyWikiEditJournal<space>-1d<Cr>
```

## New configuration

```vimscript
" Set default tags for journal entries with a space separated string
let g:tiddlywiki_journal_tags = "Journal J2022"
```
