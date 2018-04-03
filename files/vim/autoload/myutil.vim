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
