" Hooks to be used with plug.vim for bundles.
"
" a:info.status == 'installed' Plugin was installed
" a:info.status == 'updated' Plugin was updated
" a:info.force Bang (!) issued to command

function! hooks#YCMInstall(info)
  silent ! ./install.sh --clang-completer >/dev/null 2>&1 &
  redraw!
endfunction
