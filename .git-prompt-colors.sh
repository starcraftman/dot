## These are the color definitions used by gitprompt.sh

define_git_prompt_colors() {
  # These are the color definitions used by gitprompt.sh
  GIT_PROMPT_PREFIX="["                 # start of the git info string
  GIT_PROMPT_SUFFIX="]"                 # the end of the git info string
  GIT_PROMPT_SEPARATOR="|"              # separates each item

  GIT_PROMPT_BRANCH="${BoldMagenta}"    # the git branch that is active in the current directory
  GIT_PROMPT_STAGED="${Red}●"           # the number of staged files/directories
  GIT_PROMPT_CONFLICTS="${Red}✖ "       # the number of files in conflict
  GIT_PROMPT_CHANGED="${Blue}✚ "        # the number of changed files

  GIT_PROMPT_REMOTE=" "                 # the remote branch name (if any) and the symbols for ahead and behind
  GIT_PROMPT_UNTRACKED="${Cyan}…"       # the number of untracked files/dirs
  GIT_PROMPT_STASHED="${BoldBlue}⚑ "    # the number of stashed files/dir
  GIT_PROMPT_CLEAN="${BoldGreen}✔"      # a colored flag indicating a "clean" repo

  GIT_PROMPT_COMMAND_OK="${Green}✔ "    # indicator if the last command returned with an exit code of 0
  GIT_PROMPT_COMMAND_FAIL="${Red}✘${Yellow}-_LAST_COMMAND_STATE_ "   # indicator if the last command returned with an exit code of other than 0
  ## _LAST_COMMAND_INDICATOR_ will be replaced by the appropriate GIT_PROMPT_COMMAND_OK OR GIT_PROMPT_COMMAND_FAIL

  ## template for displaying the current virtual environment
  ## use the placeholder _VIRTUALENV_ will be replaced with
  ## the name of the current virtual environment (currently CONDA and VIRTUAL_ENV)
  GIT_PROMPT_VIRTUALENV="(${Blue}_VIRTUALENV_${ResetColor}) "

  # Just vars to simplify layout of PS1
  PS1_DIR="${BoldRed}\w${ResetColor}"
  PS1_USER="${Cyan}\u${ResetColor}"
  PS1_ROOT="${BoldYellow}\u${ResetColor}"
  PS1_HOST="${Green}\h${ResetColor}"
  #Time24="\$(date +%H:%M)"

  # If using ssh, usually set
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ];then
      PS1_HOST="${BoldRed}\h${ResetColor}"
  fi

  # Formats to:
  # command_indicator { directory } [vcsInfo]
  # user@host
  GIT_PROMPT_START_USER="_LAST_COMMAND_INDICATOR_${ResetColor}{ $PS1_DIR }"
  GIT_PROMPT_START_ROOT=$GIT_PROMPT_START_USER
  if [ "x" = "x$TMUX" ]; then
    GIT_PROMPT_END_USER="\n$PS1_USER@$PS1_HOST\\$ "
    GIT_PROMPT_END_ROOT="\n$PS1_ROOT@$PS1_HOST\\$ "
  else
    GIT_PROMPT_END_USER="\n$PS1_USER\\$ "
    GIT_PROMPT_END_ROOT="\n$PS1_ROOT\\$ "
  fi

  ## Please do not add colors to these symbols
  GIT_PROMPT_SYMBOLS_AHEAD="↑·"         # The symbol for "n versions ahead of origin"
  GIT_PROMPT_SYMBOLS_BEHIND="↓·"        # The symbol for "n versions behind of origin"
  GIT_PROMPT_SYMBOLS_PREHASH=":"        # Written before hash of commit, if no name could be found
}

if [[ -z "$GIT_PROMPT_SEPARATOR" || -z "$GIT_PROMPT_COMMAND_OK" ]]; then
  define_git_prompt_colors
fi
