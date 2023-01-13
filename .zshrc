### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

zinit ice from"gh-r" as"command" atload'eval "$(starship init zsh)"'
zinit load starship/starship

zinit light-mode for \
    OMZL::clipboard.zsh \
    OMZL::directories.zsh \
    OMZL::functions.zsh \
    OMZL::git.zsh \
    OMZL::grep.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::misc.zsh \
    OMZL::termsupport.zsh \
    OMZL::theme-and-appearance.zsh \
    OMZP::command-not-found \
    OMZP::colored-man-pages \
    OMZP::git \
    OMZP::fancy-ctrl-z \
    OMZP::web-search \
    rupa/z

zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions \
    OMZL::completion.zsh

alias q="exit"
alias :q="exit"
alias batt="cat /sys/class/power_supply/BAT?/capacity"
# If terminal is WezTerm, set an alias for imgcat
if [[ $TERM_PROGRAM == "WezTerm" ]]; then
  alias imgcat="wezterm imgcat"
fi

# If pacman exists, provide an update function
if [[ -f /usr/bin/pacman ]]; then
  function archup() {
    # Take sudo, if failed, exit
    sudo -v || return 1
    sudo reflector --protocol https --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
    sudo pacman -Syy
    sudo pacman -S --needed archlinux-keyring
    pacman -Qqn | grep "\-keyring$" | sudo pacman -S --needed -
    sudo pacman -Su
  }
fi
