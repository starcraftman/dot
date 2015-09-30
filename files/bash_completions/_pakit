_pakit() {
  local cur prev prog split=false
  cur=$(_get_cword "=")
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  prog="${COMP_WORDS[0]}"
  COMPREPLY=()

  _expand || return 0

  local avail mode opts
  if [ "${__COMP_CACHE_PAKIT}x" = "x" ]; then
    for i in $("$prog" --help); do
      i=${i%%=*}
      if [[ "$i" =~ ^-[a-zA-Z0-9?-]+,? ]]; then
        opts="$opts ${i//[\(\)\[.,\'\"\`]}"
      fi
    done
    avail=$(pakit --available-short 2>/dev/null)
    __COMP_CACHE_PAKIT=( "$opts" "$avail" "" )
    export __COMP_CACHE_PAKIT
  else
    opts="${__COMP_CACHE_PAKIT[0]}"
    avail="${__COMP_CACHE_PAKIT[1]}"
    mode="${__COMP_CACHE_PAKIT[2]}"
  fi

  _split_longopt && split=true

  case "${prev}" in
    # file completion
    -c|--conf)
      _filedir
      return 0
      ;;
    # complete available programs
    -d|-i|--display|--install)
      COMPREPLY=( $(compgen -W "${avail}" -- "${cur}") )
      return 0
      ;;
    # complete installed programs
    -r|--remove)
      mode="remove"
      __COMP_CACHE_PAKIT=( "$opts" "$avail" "$mode" )
      export __COMP_CACHE_PAKIT

      installed=$(pakit --list-short 2>/dev/null)
      COMPREPLY=( $(compgen -W "${installed}" -- "${cur}") )
      return 0
      ;;
    # require args, no completion
    -a|-h|-k|-l|-u|-v|--available*|--create-conf|--help|--list*|\
        --search|--update|--version)
      return 0
      ;;
  esac

  # reset mode if not removing
  case "${prev}" in
    -r|--remove)
      ;;
    -*)
      __COMP_CACHE_PAKIT=( "$opts" "$avail" "" )
      export __COMP_CACHE_PAKIT
      ;;
  esac

  $split && return 0

  case "${cur}" in
    -*)
      COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
      return 0
      ;;
    *)
      if [ "$mode" = "remove" ]; then
        installed=$(pakit --list-short 2>/dev/null)
        COMPREPLY=( $(compgen -W "${installed}" -- "${cur}") )
      else
        COMPREPLY=( $(compgen -W "${avail}" -- "${cur}") )
      fi
      return 0
      ;;
  esac
}

have pakit && complete -F _pakit ${nospace} pakit
# vim:set ft=sh ts=2 sts=2 sw=2:
