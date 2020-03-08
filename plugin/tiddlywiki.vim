" Vim plugin for TiddlyWiki
" Language: tiddlywiki
" Maintainer: Devin Weaver <suki@tritarget.org>
" Maintainer: Christian Reiniger <creinig@creinig.e>
" License: http://www.apache.org/licenses/LICENSE-2.0.txt



" check if the given dir contains at least one system tiddler
function! s:HasSystemTiddlers(dir) 
  return len(globpath(a:dir, '$__*.tid', 1, 1)) > 0
endfunction

" Determine the dir containing all tiddlers
function! s:TiddlyWikiDir()
  if exists("s:tiddlywiki_dir")
    if s:tiddlywiki_dir == ''
      echom 'ERROR: tiddler dir could not be determined'
    endif
    return s:tiddlywiki_dir
  endif

  let candidates = []

  if exists("g:tiddlywiki_dir")
    let candidates = [g:tiddlywiki_dir, g:tiddlywiki_dir . '/tiddlers']
  else
    let candidates = ['.', './tiddlers', '~/wiki', '~/wiki/tiddlers']
  endif

  for candidate in candidates
    let abs = fnamemodify(candidate, ':p')
    if(s:HasSystemTiddlers(abs))
      silent echom "Tiddler dir = <"  abs  ">"
      let s:tiddlywiki_dir = abs
      return abs
    endif
  endfor

  echom 'ERROR: tiddler dir could not be determined'
  return ''
endfunction




" Open the tiddler with the given name. If it doesn't exist, create and
" initialize it
function! s:EditOrCreate(name)
  let tiddler_dir = s:TiddlyWikiDir()
  if tiddler_dir == ''
    return
  endif

  let fqn = tiddler_dir . a:name . '.tid'
  execute 'edit ' . fqn

  if ! filereadable(fqn)
    TiddlyWikiInitializeTemplate
  endif
endfunction




" Define commands, allowing the user to define custom mappings
command -nargs=1 TiddlyWikiEditTiddler call <SID>EditOrCreate('<args>')

" Define some default mappings unless disabled
if !exists("g:tiddlywiki_no_mappings")
  nmap <Leader>te :TiddlyWikiEditTiddler<Space>
  nmap <Leader>tE :vsplit<cr>:TiddlyWikiEditTiddler<Space>
endif


