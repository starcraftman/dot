" Store my own utiliy funcs here

" Hooks to be used with plug.vim for bundles.
"
" a:info.status == 'installed' Plugin was installed
" a:info.status == 'updated' Plugin was updated
" a:info.force Bang (!) issued to command

function! myutil#ycm_hook(info)
  let l:opts =  '--clang-completer '
  if executable('go')
    let l:opts .= '--go-completer '
  endif
  if executable('rustc')
    let l:opts .= '--rust-completer '
  endif
  if executable('java')
    let l:opts .= '--java-completer '
  endif
  if executable('nodejs') && executable('npm')
    let l:opts .= '--ts-completer '
  endif
  " if executable('mono')
    " let l:opts .= '--cs-completer '
  " endif

  let l:line = printf('%s %s', expand(g:vim_dir . '/plugged/YouCompleteMe/install.py'), l:opts)
  let l:suffix = ''
  if has('nvim')
    let l:suffix = 'Neovim'
  endif
  echomsg 'RUNNING:'
  echomsg printf('%s >/tmp/YCMBuild%s &', l:line, l:suffix)
  silent execute printf('! echo %s >/tmp/YCMBuild%s &', l:line, l:suffix)
  silent execute printf('! %s >>/tmp/YCMBuild%s 2>&1 &', l:line, l:suffix)
endfunction

function! myutil#run()
  let l:cmd = exists('b:amake_run') ? b:amake_run : g:amake_run
  let l:file = expand('%:p')
  execute 'AsyncRun ' . substitute(l:cmd, '%f', l:file, '')
endfunction

function! myutil#test()
  let l:cmd = exists('b:amake_test') ? b:amake_test : g:amake_test
  let l:file = expand('%:p')
  execute 'AsyncRun ' . substitute(l:cmd, '%f', l:file, '')
endfunction

" Get last visual selection as text.
function! myutil#vselect()
    let [l:line_start, l:column_start] = getpos("'<")[1:2]
    let [l:line_end, l:column_end] = getpos("'>")[1:2]
    let l:lines = getline(l:line_start, l:line_end)

    if len(l:lines) == 0
        return ''
    endif

    let l:lines[-1] = l:lines[-1][: l:column_end - (&selection ==? 'inclusive' ? 1 : 2)]
    let l:lines[0] = l:lines[0][l:column_start - 1:]
    return join(l:lines, "\n")
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
