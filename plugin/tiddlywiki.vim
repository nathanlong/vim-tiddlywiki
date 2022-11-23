" Vim plugin for TiddlyWiki
" Language: tiddlywiki
" Maintainer: Devin Weaver <suki@tritarget.org>
" Maintainer: Christian Reiniger <creinig@creinig.e>
" License: http://www.apache.org/licenses/LICENSE-2.0.txt


" Open the tiddler with the given name. If it doesn't exist, create and
" initialize it
function! s:EditOrCreate(name)
  let tiddler_dir = tiddlywiki#TiddlyWikiDir()
  if tiddler_dir == ''
    return
  endif

  if a:name == '' 
    call tiddlywiki#FuzzyFindTiddler('TiddlyWikiEditTiddler')
    return
  endif

  let fqn = tiddler_dir . a:name . '.tid'
  execute 'edit ' . fqn

  if ! filereadable(expand(fqn))
    TiddlyWikiInitializeTemplate
  endif
endfunction

" TODO: allow empty argument for manual journal commands
"
" Open the journal tiddler for today. If it doesn't exist, create and
" initialize it
function! s:EditOrCreateJournal(dateMod)
  if tiddlywiki#TiddlyWikiDir() == ''
    return
  endif

  let name = tiddlywiki#GetJournalTiddlerName(a:dateMod)
  let fqn = tiddlywiki#TiddlyWikiDir() . name . '.tid'
  execute 'edit ' . fqn

  if ! filereadable(fqn)
    TiddlyWikiInitializeJournal
  endif
endfunction




" Define commands, allowing the user to define custom mappings
command! -complete=customlist,tiddlywiki#CompleteTiddlerName
       \ -nargs=? TiddlyWikiEditTiddler call <SID>EditOrCreate('<args>')
command! -nargs=? TiddlyWikiEditJournal call <SID>EditOrCreateJournal() 

" Define some default mappings unless disabled
if !exists("g:tiddlywiki_no_mappings")
  nmap <Leader>te :TiddlyWikiEditTiddler<Space>
  nmap <Leader>tE :vsplit<cr>:TiddlyWikiEditTiddler<Space>
  nmap <Leader>tj :TiddlyWikiEditJournal<space>+0d<Cr>
  nmap <Leader>tJ :vsplit<cr>:TiddlyWikiEditJournal<space>+0d<Cr>
  nmap <Leader>tk :TiddlyWikiEditJournal<space>+1d<Cr>
  nmap <Leader>tK :TiddlyWikiEditJournal<space>-1d<Cr>
endif


