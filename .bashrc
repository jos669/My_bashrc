# ╔══════════════════════════════════════════════════════════════════╗
# ║              ~/.bashrc — PRO EDITION  (Kali-style)              ║
# ║         by Claude · github-ready · termix/tmux/zsh-compat       ║
# ╚══════════════════════════════════════════════════════════════════╝

# ── 0. GUARDAS ─────────────────────────────────────────────────────
# No ejecutar en shells no-interactivos
[[ $- != *i* ]] && return

# ── 1. HISTORIAL ────────────────────────────────────────────────────
HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT="%F %T  "
HISTIGNORE="ls:ll:la:pwd:exit:clear:bg:fg:history"
shopt -s histappend
shopt -s cmdhist

# Función para actualizar el historial sin romper PROMPT_COMMAND
__update_history() {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND="__update_history"

# ── 2. OPCIONES DE SHELL ────────────────────────────────────────────
shopt -s autocd          # cd solo escribiendo el nombre del dir
shopt -s cdspell         # corrige typos en cd
shopt -s checkwinsize    # actualiza LINES/COLUMNS al cambiar tamaño
shopt -s dirspell        # corrige nombres de directorios
shopt -s dotglob         # globs incluyen dotfiles
shopt -s extglob         # patrones extendidos: +(x), ?(x), *(x)
shopt -s globstar        # ** para recursividad
shopt -s nocaseglob      # globs case-insensitive
shopt -s expand_aliases

# ── 3. VARIABLES DE ENTORNO ─────────────────────────────────────────
export EDITOR="nvim"                        # Usando Neovim por defecto
export VISUAL="$EDITOR"
export PAGER="less"
export LESS="-R --use-color -Dd+r -Du+b"    # colores en less
export LESSHISTFILE="/dev/null"             # no guardar historial less
export GREP_COLOR='1;32'
export GREP_COLORS='mt=1;32'
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'
export CLICOLOR=1
export COLORTERM=truecolor
export TERM="${TERM:-xterm-256color}"
export LANG="C.UTF-8"
export LC_ALL="C.UTF-8"
export MANPAGER="sh -c 'col -bx | bat -l man -p'" 2>/dev/null || export MANPAGER="less"
export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1
export PIP_REQUIRE_VIRTUALENV=0
export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$HOME/bin:$GOPATH/bin:$HOME/.cargo/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"

# ── 4. COLORES ──────────────────────────────────────────────────────
# Paleta ANSI reutilizable en el prompt y funciones
RESET="\[\e[0m\]"
BOLD="\[\e[1m\]"
DIM="\[\e[2m\]"
RED="\[\e[38;5;196m\]"
GREEN="\[\e[38;5;46m\]"
YELLOW="\[\e[38;5;226m\]"
BLUE="\[\e[38;5;39m\]"
MAGENTA="\[\e[38;5;201m\]"
CYAN="\[\e[38;5;51m\]"
WHITE="\[\e[38;5;255m\]"
ORANGE="\[\e[38;5;208m\]"
GRAY="\[\e[38;5;154m\]"
PURPLE="\[\e[38;5;141m\]"

# Colores sin escaping (para uso en echo/printf)
C_RED="\e[38;5;196m";    C_RST="\e[0m"
C_GREEN="\e[38;5;46m";   C_YEL="\e[38;5;226m"
C_CYAN="\e[38;5;51m";    C_MAG="\e[38;5;201m"
C_BLU="\e[38;5;39m";     C_ORA="\e[38;5;208m"
C_PUR="\e[38;5;141m";    C_GRY="\e[38;5;154m"


# ── 5. PROMPT (Kali Skull Edition - ElXD502) ───────────────────────────
__git_info() {
  local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  if [[ -n "$branch" ]]; then
    local status=$(git status --porcelain 2>/dev/null | tail -n1)
    local dirty=""
    [[ -n "$status" ]] && dirty="*"
    echo -e " ${PURPLE}($branch$dirty)${RESET}"
  fi
}

__exit_code() {
  local exit_status=$?
  if [ $exit_status -ne 0 ]; then
    echo -e "${RED}[✗$exit_status]${RESET} "
  fi
}

# Prompt multilínea:
# ┌──[💀 ElXD502㉿ANDROID]──[~]
# └─❯ 
PS1="\[${GRAY}\]┌──[\[${CYAN}\]💀 ElXD502\[${GRAY}\]㉿\[${BLUE}\]ANDROID\[${GRAY}\]]──[\[${GREEN}\]\w\[${GRAY}\]]\[\$(__git_info)\]\n"
PS1+="\[${GRAY}\]└─\[${RED}\]❯ \[\$(__exit_code)\]\[${RESET}\] "

PS2="${GRAY}  ╎${RESET} "                         # prompt continuación

# ── 6. TÍTULOS DE VENTANA / TMUX ────────────────────────────────────
case "$TERM" in
  xterm*|rxvt*|*256color|screen*|tmux*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
esac

# ── 7. ALIASES ESENCIALES ───────────────────────────────────────────

## Termux Específicos
alias update='pkg update && pkg upgrade'
alias install='pkg install'
alias psearch='pkg search'
alias list='pkg list-installed'
alias clean='pkg clean'

## Navegación
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

## Listados
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lhF --color=auto --group-directories-first'
alias la='ls -lahF --color=auto --group-directories-first'
alias l='ls -CF --color=auto'
alias lt='ls -lhFt --color=auto'        # ordenado por tiempo
alias lS='ls -lhFS --color=auto'        # ordenado por tamaño
alias tree='tree -C --dirsfirst'
alias t2='tree -C --dirsfirst -L 2'
alias t3='tree -C --dirsfirst -L 3'

## Seguridad (pide confirmación)
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ln='ln -iv'

## grep con color
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias rgrep='grep -rn --color=auto'

## Editores
alias nano='nano -l'
alias v='$EDITOR'

## Red y sistema
alias ip='ip -color=auto'
alias ping='ping -c 5'
alias ports='ss -tulpn'
alias myip='curl -s https://ipinfo.io/ip && echo'
alias localip="ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v 127"
alias netstat='ss -s'
alias ipt='sudo iptables -L -n -v --line-numbers'
alias ip6t='sudo ip6tables -L -n -v --line-numbers'

## Procesos
alias psa='ps auxf'
alias psg='ps aux | grep -v grep | grep -i'
alias top='top -u $USER'
alias htop='htop -u $USER'
alias kill9='kill -9'
alias meminfo='free -h'
alias cpuinfo='lscpu'
alias diskinfo='df -hT'
alias duh='du -sh * | sort -rh'
alias openfiles='lsof -i'

## Git (nivel pro)
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gl='git pull'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gloga='glog --all'
alias gd='git diff'
alias gds='git diff --staged'
alias gb='git branch -vv'
alias gba='git branch -a -vv'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gst='git stash'
alias gstp='git stash pop'
alias grb='git rebase'
alias gri='git rebase -i'
alias gmr='git merge'
alias gfetch='git fetch --all --prune'
alias gtag='git tag -l | sort -V'
alias gwip='git add -A && git commit -m "WIP: $(date +%F\ %T)"'

## Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dpsa='docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"'
alias di='docker images'
alias drm='docker rm $(docker ps -aq)'
alias drmi='docker rmi $(docker images -q)'
alias dprune='docker system prune -af --volumes'
alias dlogs='docker logs -f'
alias dexec='docker exec -it'
alias dstop='docker stop $(docker ps -q)'

## Python / pip
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv'
alias activate='source .venv/bin/activate 2>/dev/null || source venv/bin/activate 2>/dev/null'
alias pipi='pip install'
alias pipr='pip install -r requirements.txt'
alias freeze='pip freeze > requirements.txt'

## Herramientas de pentesting (Kali)
alias nmap='sudo nmap'
alias nse='ls /usr/share/nmap/scripts/ | grep'
alias hydra='hydra -V'
alias sqlmap='python3 /usr/share/sqlmap/sqlmap.py'
alias msfconsole='msfconsole -q'
alias searchsploit='searchsploit --color'
alias burp='java -jar ~/tools/burpsuite*.jar 2>/dev/null &'
alias wfuzz='wfuzz -c'
alias ffuf='ffuf -c'
alias nikto='nikto -C all'
alias gobuster='gobuster dir'
alias ferox='feroxbuster'

## Herramientas de análisis
alias strings='strings -a'
alias hexdump='hexdump -C'
alias xxd='xxd -g 1'
alias binwalk='binwalk -Me'
alias strace='strace -f -e trace=all'
alias ltrace='ltrace -f'
alias gdb='gdb -q'

## Misc útiles
alias c='clear'
alias q='exit'
alias h='history | grep'
alias reload='source ~/.bashrc && echo "✓ .bashrc recargado"'
alias bashrc='$EDITOR ~/.bashrc'
alias aliases='grep "^alias" ~/.bashrc | sed "s/alias //;s/=/ → /" | sort | column -t -s "→"'
alias path='echo -e "${PATH//:/\\n}"'
alias week='date +%V'
alias now='date +"%T"'
alias nowdate='date +"%d-%m-%Y"'
alias wget='wget -c --show-progress'                  # wget con resume
alias curl='curl -L --silent --show-error'
alias sz='du -sh'
alias extract='_extract'                              # función definida abajo
alias compress='tar -czvf'
alias untar='tar -xzvf'
alias ssha='eval $(ssh-agent) && ssh-add'
alias sshkey='cat ~/.ssh/id_rsa.pub'
alias genpass='openssl rand -base64 32'
alias md5='md5sum'
alias sha='sha256sum'
alias b64e='base64'
alias b64d='base64 -d'
alias urle='python3 -c "import sys,urllib.parse;print(urllib.parse.quote(sys.argv[1]))"'
alias urld='python3 -c "import sys,urllib.parse;print(urllib.parse.unquote(sys.argv[1]))"'
alias json='python3 -m json.tool'
alias serve='python3 -m http.server'
alias clipboard='xclip -selection clipboard'         # Linux X11
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# ── 8. FUNCIONES PRO ────────────────────────────────────────────────

# Banner de bienvenida al abrir terminal
__banner() {
  echo -e "${C_CYAN}"
  echo "  ███████╗██╗     ██╗  ██╗██████╗ ███████╗ ██████╗ ██████╗ "
  echo "  ██╔════╝██║     ╚██╗██╔╝██╔══██╗██╔════╝██╔═████╗╚════██╗"
  echo "  █████╗  ██║      ╚███╔╝ ██║  ██║███████╗██║██╔██║ █████╔╝"
  echo "  ██╔══╝  ██║      ██╔██╗ ██║  ██║╚════██║████╔╝██║██╔═══╝ "
  echo "  ███████╗███████╗██╔╝ ██╗██████╔╝███████║╚██████╔╝███████╗"
  echo "  ╚══════╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝"
  echo -e "${C_RST}"
  echo -e "  ${C_GRY}Bienvenido, ${C_CYAN}ElXD502${C_RST} | ${C_GRY}$(uname -o)${C_RST}"
  echo -e "  ${C_GRY}Fecha: $(date '+%D %T') | IP: $(hostname -I 2>/dev/null | awk '{print $1}')${C_RST}"
  echo ""
}
# Ejecutar banner al iniciar
__banner

# Extractor universal
_extract() {
  if [[ -z "$1" ]]; then
    echo "Uso: extract <archivo>"
    return 1
  fi
  local f="$1"
  case "$f" in
    *.tar.bz2)   tar -xjvf "$f"    ;;
    *.tar.gz)    tar -xzvf "$f"    ;;
    *.tar.xz)    tar -xJvf "$f"    ;;
    *.tar.zst)   tar -I zstd -xvf "$f" ;;
    *.tar)       tar -xvf  "$f"    ;;
    *.tbz2)      tar -xjvf "$f"    ;;
    *.tgz)       tar -xzvf "$f"    ;;
    *.bz2)       bunzip2   "$f"    ;;
    *.rar)       unrar x   "$f"    ;;
    *.gz)        gunzip    "$f"    ;;
    *.zip)       unzip     "$f"    ;;
    *.Z)         uncompress "$f"   ;;
    *.7z)        7z x      "$f"    ;;
    *.xz)        unxz      "$f"    ;;
    *.lzma)      unlzma    "$f"    ;;
    *.deb)       ar x      "$f"    ;;
    *)           echo "No sé cómo extraer '$f'" ; return 1 ;;
  esac
}

# Hacer un directorio e ir a él
mkcd() { mkdir -p "$1" && cd "$1" || return; }

# Buscar en archivos
ff()  { find . -type f -iname "*$1*" 2>/dev/null; }
fd()  { find . -type d -iname "*$1*" 2>/dev/null; }

# Grep recursivo rápido
search() { grep -rn --color=auto "$1" "${2:-.}"; }

# Ver cabeceras HTTP
headers() { curl -sI "$1" | less; }

# Ver certificado TLS de un host
cert() { echo | openssl s_client -connect "$1:${2:-443}" 2>/dev/null | openssl x509 -noout -text; }

# Escaneo rápido de puertos (nmap)
scan() {
  local host="${1:?Uso: scan <host> [puertos]}"
  local ports="${2:-1-65535}"
  sudo nmap -sV -sC -T4 -p "$ports" "$host"
}

# Reverseshell listener rápido
listen() {
  local port="${1:-4444}"
  echo -e "${C_GRY}[*] Escuchando en 0.0.0.0:$port${C_RST}"
  nc -lvnp "$port"
}

# Base64 encode/decode interactivo
b64() {
  if [[ "$1" == "-d" ]]; then
    echo "$2" | base64 -d
  else
    echo "$1" | base64
  fi
}

# Conversión de número a hex/bin/oct
num() {
  local n="$1"
  printf "DEC: %d\nHEX: %x\nOCT: %o\nBIN: " "$n" "$n" "$n"
  python3 -c "print(bin(int('$n')).replace('0b',''))"
}

# Mostrar colores del terminal
colors() {
  for i in {0..255}; do
    printf "\e[38;5;${i}m %3d " "$i"
    [[ $((($i+1)%16)) -eq 0 ]] && echo
  done
  echo -e "\e[0m"
}

# Backup rápido de archivo
bak() { cp "$1" "$1.bak.$(date +%Y%m%d%H%M%S)"; echo "✓ Backup: $1.bak.*"; }

# Descargar y ejecutar script remoto de forma segura (muestra antes de ejecutar)
safe_run() {
  local url="$1"
  local tmp; tmp=$(mktemp)
  curl -fsSL "$url" -o "$tmp"
  echo -e "${C_YEL}[!] Contenido del script:${C_RST}"
  cat "$tmp"
  echo -e "\n${C_YEL}[?] ¿Ejecutar? [s/N]${C_RST}"
  read -r ans
  [[ "$ans" =~ ^[sS]$ ]] && bash "$tmp"
  rm -f "$tmp"
}

# Crear servidor HTTP con Python + mostrar IP
webserver() {
  local port="${1:-8080}"
  local ip; ip=$(hostname -I | awk '{print $1}')
  echo -e "${C_GRY}[*] Servidor en http://$ip:$port${C_RST}"
  python3 -m http.server "$port"
}

# Calcular hash de archivo
hashes() {
  local f="${1:?Uso: hashes <archivo>}"
  echo "MD5:    $(md5sum    "$f" | awk '{print $1}')"
  echo "SHA1:   $(sha1sum   "$f" | awk '{print $1}')"
  echo "SHA256: $(sha256sum "$f" | awk '{print $1}')"
}

# Mostrar info del proceso por nombre
pinfo() { ps aux | grep -v grep | grep -i "$1"; }

# Reemplazar texto en múltiples archivos
replace() {
  local from="${1:?Uso: replace <de> <a> [glob]}"
  local to="${2:?}"
  local glob="${3:-*}"
  grep -rl "$from" . --include="$glob" | xargs sed -i "s|$from|$to|g"
  echo "✓ Reemplazo completado"
}

# Diff bonito entre dos archivos
diff() { command diff --color=auto -u "$@"; }

# Conectar a máquina CTF por SSH
ctf_ssh() {
  local host="${1:?Uso: ctf_ssh <ip> [user] [port]}"
  local user="${2:-root}"
  local port="${3:-22}"
  ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$user@$host" -p "$port"
}

# Generar wordlist personalizada
wordlist() {
  local base="${1:?Uso: wordlist <base_word>}"
  python3 - <<EOF
import itertools
base = "$base"
subs = {'a':'4','e':'3','i':'1','o':'0','s':'5','t':'7'}
words = {base, base.upper(), base.capitalize()}
for c, r in subs.items():
    words.add(base.replace(c, r))
for w in sorted(words):
    print(w)
    print(w + "!")
    print(w + "123")
    print(w + "2024")
    print(w + "@2024")
EOF
}

# Monitorear un archivo de log
tailog() { tail -f "${1:-/var/log/syslog}" | grep --color=always -E '^|error|warn|fail|crit'; }

# Resumen rápido del sistema
sysinfo() {
  echo -e "${C_BLU}═══════════════ SYSTEM INFO ═══════════════${C_RST}"
  echo -e "${C_GRY}OS:      ${C_RST}$(lsb_release -ds 2>/dev/null || uname -s)"
  echo -e "${C_GRY}Kernel:  ${C_RST}$(uname -r)"
  echo -e "${C_GRY}Host:    ${C_RST}$(hostname)"
  echo -e "${C_GRY}CPU:     ${C_RST}$(grep 'model name' /proc/cpuinfo | head -1 | cut -d: -f2 | xargs)"
  echo -e "${C_GRY}RAM:     ${C_RST}$(free -h | awk '/^Mem:/{print $3"/"$2}')"
  echo -e "${C_GRY}Disco:   ${C_RST}$(df -h / | awk 'NR==2{print $3"/"$2" ("$5")"}')"
  echo -e "${C_GRY}IP local:${C_RST} $(hostname -I 2>/dev/null | awk '{print $1}')"
  echo -e "${C_GRY}Uptime:  ${C_RST}$(uptime -p)"
  echo -e "${C_GRY}Shell:   ${C_RST}$BASH_VERSION"
}

# Auto-activar virtualenv al entrar a un directorio
_auto_venv() {
  if [[ -f ".venv/bin/activate" || -f "venv/bin/activate" ]]; then
    local vpath=".venv/bin/activate"
    [[ -f "venv/bin/activate" ]] && vpath="venv/bin/activate"
    if [[ "$VIRTUAL_ENV" != "$(pwd)/${vpath%/*}/.." ]]; then
      source "$vpath"
      echo -e "${C_GRY}[venv] Activado: $VIRTUAL_ENV${C_RST}"
    fi
  fi
}
# Auto deactivate si salimos del dir del venv
_auto_deactivate_venv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    if [[ "$(pwd)" != "$VIRTUAL_ENV"* ]]; then
      deactivate 2>/dev/null
      echo -e "${C_GRY}[venv] Desactivado${C_RST}"
    fi
  fi
}
cd() {
  builtin cd "$@" && _auto_venv && _auto_deactivate_venv
  echo -e "\n${C_GRY}── Contenido de ${C_GREEN}$(pwd | sed "s|$HOME|~|")${C_GRY} ──${C_RST}"
  if command -v eza &>/dev/null; then
    eza --icons --group-directories-first
  else
    ls --color=auto --group-directories-first
  fi
  
  if [[ -d .git ]]; then
    echo -e "\n${C_PUR} Git Repository:${C_RST}"
    git status -sb
  fi
}

# ── 9. COMPLETADO INTELIGENTE ───────────────────────────────────────
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  source /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
  source /etc/bash_completion
fi

# Git completions
if [[ -f /usr/share/bash-completion/completions/git ]]; then
  source /usr/share/bash-completion/completions/git
fi
__git_complete g   __git_main    2>/dev/null
__git_complete gc  _git_commit   2>/dev/null
__git_complete gco _git_checkout 2>/dev/null
__git_complete gb  _git_branch   2>/dev/null

# Completado inteligente: ignora case, muestra todas las opciones
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "set colored-stats on"
bind "set visible-stats on"
bind "set mark-symlinked-directories on"
bind "set colored-completion-prefix on"
bind "set menu-complete-display-prefix on"

# ── 10. KEYBINDINGS ─────────────────────────────────────────────────
bind '"\e[A": history-search-backward'  # ↑ busca en historial
bind '"\e[B": history-search-forward'   # ↓
bind '"\C-f": forward-word'             # Ctrl+F → avanza palabra
bind '"\C-b": backward-word'            # Ctrl+B ← retrocede palabra
bind '"\C-o": operate-and-get-next'     # Ctrl+O ejecuta y trae siguiente
bind '"\C-l": clear-screen'             # Ctrl+L limpia pantalla

# ── 11. TMUX ────────────────────────────────────────────────────────
# Auto-attach a sesión tmux si estamos en terminal interactivo y no dentro de tmux ya
# Descomenta para activar:
# if command -v tmux &>/dev/null && [[ -z "$TMUX" ]] && [[ "$TERM_PROGRAM" != "vscode" ]]; then
#   tmux attach-session -t main 2>/dev/null || tmux new-session -s main
# fi

# Alias de tmux
alias tm='tmux'
alias tma='tmux attach-session -t'
alias tmn='tmux new-session -s'
alias tml='tmux list-sessions'
alias tmk='tmux kill-session -t'
alias tmkall='tmux kill-server'

# ── 12. FZF (fuzzy finder) ──────────────────────────────────────────
if command -v fzf &>/dev/null; then
  # Carga keybindings y completado de fzf
  [[ -f /usr/share/doc/fzf/examples/key-bindings.bash ]] && \
    source /usr/share/doc/fzf/examples/key-bindings.bash
  [[ -f /usr/share/bash-completion/completions/fzf ]] && \
    source /usr/share/bash-completion/completions/fzf

  export FZF_DEFAULT_OPTS="--ansi --height 40% --border --layout=reverse \
    --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 \
    --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 \
    --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 \
    --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git 2>/dev/null || find . -type f'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git 2>/dev/null || find . -type d'

  # Ctrl+R: historial con fzf
  fh() {
    local cmd
    cmd=$(history | awk '{$1=""; print}' | sort -u | fzf --tac --no-sort)
    [[ -n "$cmd" ]] && eval "$cmd"
  }

  # fkill: matar proceso interactivo
  fkill() {
    local pid
    pid=$(ps aux | grep -v grep | fzf | awk '{print $2}')
    [[ -n "$pid" ]] && kill -"${1:-9}" "$pid" && echo "✓ PID $pid eliminado"
  }
fi

# ── 13. HERRAMIENTAS MODERNAS (si existen) ──────────────────────────
command -v eza    &>/dev/null && alias ls='eza --icons --group-directories-first'  \
                               && alias ll='eza -lhF --icons --git --group-directories-first' \
                               && alias la='eza -lahF --icons --git --group-directories-first'
command -v bat    &>/dev/null && alias cat='bat --style=auto'
command -v delta  &>/dev/null && export GIT_PAGER='delta'
command -v rg     &>/dev/null && alias grep='rg --color=always'
command -v zoxide &>/dev/null && eval "$(zoxide init bash)" && alias cd='z'
command -v thefuck &>/dev/null && eval "$(thefuck --alias)"
command -v direnv  &>/dev/null && eval "$(direnv hook bash)"

# ── 14. NVM / ASDF / PYENV ──────────────────────────────────────────
# NVM
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# ASDF
[[ -f "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh"
[[ -f "$HOME/.asdf/completions/asdf.bash" ]] && source "$HOME/.asdf/completions/asdf.bash"

# pyenv
if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)" 2>/dev/null
fi

# rbenv
if command -v rbenv &>/dev/null; then
  eval "$(rbenv init -)"
fi

# ── 15. SSH-AGENT PERSISTENTE ───────────────────────────────────────
_ssh_agent_start() {
  local env_file="$HOME/.ssh/agent.env"
  if [[ -f "$env_file" ]]; then
    source "$env_file" >/dev/null
    if kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
      return
    fi
  fi
  eval "$(ssh-agent)" | head -2 > "$env_file"
  chmod 600 "$env_file"
  source "$env_file" >/dev/null
  ssh-add "$HOME/.ssh/id_rsa" 2>/dev/null
  ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null
}
# Descomenta para habilitar ssh-agent automático:
# _ssh_agent_start

# ── 16. MOTD PERSONALIZADO ──────────────────────────────────────────
_motd() {
  local hostname ip kernel mem
  hostname=$(hostname)
  ip=$(hostname -I 2>/dev/null | awk '{print $1}')
  kernel=$(uname -r)
  mem=$(free -h | awk '/^Mem:/{print $3"/"$2}')

  echo -e "${C_MAG}┌─────────────────────────────────────────────────┐${C_RST}"
  printf "${C_MAG}│${C_RST}  ${C_GRY}Host:${C_RST} %-15s  ${C_GRY}IP:${C_RST} %-18s ${C_MAG}│${C_RST}\n" "$hostname" "$ip"
  printf "${C_MAG}│${C_RST}  ${C_GRY}Kernel:${C_RST} %-38s ${C_MAG}│${C_RST}\n" "$kernel"
  printf "${C_MAG}│${C_RST}  ${C_GRY}RAM:${C_RST} %-15s  ${C_GRY}Fecha:${C_RST} %-16s ${C_MAG}│${C_RST}\n" "$mem" "$(date '+%F %T')"
  echo -e "${C_MAG}└─────────────────────────────────────────────────┘${C_RST}"
}
# Descomenta para ver info al abrir terminal:
# _motd

# ── 17. ARCHIVOS LOCALES OPCIONALES ─────────────────────────────────
# Carga configuración adicional si existe (trabajo, cliente, proyecto, etc.)
[[ -f ~/.bashrc.local   ]] && source ~/.bashrc.local
[[ -f ~/.bash_aliases   ]] && source ~/.bash_aliases
[[ -f ~/.bash_functions ]] && source ~/.bash_functions
[[ -d ~/.bashrc.d ]] && for f in ~/.bashrc.d/*.bash; do source "$f"; done

# ── FIN ─────────────────────────────────────────────────────────────
# "The quieter you become, the more you can hear." — Kali Linux motto
