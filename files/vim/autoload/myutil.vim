" Store my own utiliy funcs here

" Hooks to be used with plug.vim for bundles.
"
" a:info.status == 'installed' Plugin was installed
" a:info.status == 'updated' Plugin was updated
" a:info.force Bang (!) issued to command

function! myutil#ycm_hook(info)
  let opts =  '--clang-completer '
  if executable('go')
    let opts .= '--gocode-completer '
  endif
  "if executable('mono')
    "let opts .= '--omnisharp-completer '
  "endif
  "if executable('nodejs') && executable('npm')
    "let opts .= '--tern-completer '
  "endif
  if executable('rustc')
    let opts .= '--racer-completer '
  endif
  if executable('java')
    let java_version = split(system('java -version'), '\n')[0]
    if stridx(java_version, 'java version "10"') == 0
      let opts .= '--java-completer'
    endif
  endif
  let line = printf("%s %s", expand(g:vim_dir . '/plugged/YouCompleteMe/install.py'), opts)
  echomsg line
  if has('nvim')
    new
    call termopen(line)
  else
    execute '! ' . line . ' >/tmp/YCMBuild 2>&1 &'
  endif
  redraw!
endfunction

function! myutil#run()
  let cmd = exists('b:amake_run') ? b:amake_run : g:amake_run
  execute 'AsyncRun! ' . cmd
endfunction

function! myutil#test()
  let cmd = exists('b:amake_test') ? b:amake_test : g:amake_test
  execute 'AsyncRun ' . cmd
endfunction

" Archived, not really happy with it atm

"autocmd BufRead * call Vex.Off()

" Make a NERDTree like side buffer
"let g:Vex = {}
"function! Vex.Toggle()
  "if exists('t:vex')
    "call self.Close()
  "else
    "call self.Open()
  "endif
"endfunction

"function! Vex.Off()
  "if exists('t:vex')
    "call self.Close()
  "endif
"endfunction

"function! Vex.Open()
  "let t:vex = {'orig_buf': winnr(), 'orig_bsplit': g:netrw_browse_split}
  "let g:netrw_browse_split = 4

  "topleft vnew
  "wincmd H
  "execute 'vertical resize ' . g:NERDTreeWinSize
  "Explore

  "nmap <buffer> <silent> q :call Vex.Close()<CR>
  "nmap <buffer> <silent> o :call Vex.Action('new')<CR>
  "nmap <buffer> <silent> O :call Vex.Action('vnew')<CR>

  "let t:vex.new_buf = bufnr('%')
"endfunction

"function! Vex.Close()
  "let vex_buf = bufwinnr(t:vex.new_buf)

  "if vex_buf != -1
    "execute vex_buf . ' wincmd w'
    "close
    "execute t:vex.orig_buf . ' wincmd w'
  "endif

  "let g:netrw_browse_split = t:vex.orig_bsplit
  "unlet t:vex
"endfunction

"function! Vex.Action(action)
  "let l:orig_win = winnr()
  "wincmd l
  "execute a:action
  "let t:vex.orig_buf = winnr() - 1
  "execute l:orig_win . ' wincmd w'
  "call feedkeys("\<CR>", 't')
"endfunction
