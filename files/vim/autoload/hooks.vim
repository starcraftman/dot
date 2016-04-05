" Hooks to be used with plug.vim for bundles.
"
" a:info.status == 'installed' Plugin was installed
" a:info.status == 'updated' Plugin was updated
" a:info.force Bang (!) issued to command

function! hooks#YCMInstall(info)
  let opts =  '--clang-completer '
  if executable('go')
    let opts .= '--gocode-completer '
  endif
  if executable('mono')
    let opts .= '--omnisharp-completer '
  endif
  if executable('nodejs') && executable('npm')
    let opts .= '--tern-completer '
  endif
  if executable('rustc')
    let opts .= '--racer-completer '
  endif
  silent execute '! ./install.py ' . opts . '>/tmp/YCMBuild 2>&1 &'
  redraw!
endfunction
