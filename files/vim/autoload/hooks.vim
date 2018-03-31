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
  "if executable('mono')
    "let opts .= '--omnisharp-completer '
  "endif
  if executable('nodejs') && executable('npm')
    let opts .= '--tern-completer '
  endif
  if executable('rustc')
    let opts .= '--racer-completer '
  endif
  if executable('java')
    let java_version = split(system('java -version'), '\n')[0]
    echomsg java_version
    if stridx(java_version, 'java version "10"') == 0
      let opts .= '--java-completer'
    endif
  endif
  echomsg './install.py ' . opts
  silent execute '! ./install.py ' . opts . '>/tmp/YCMBuild 2>&1 &'
  redraw!
endfunction
