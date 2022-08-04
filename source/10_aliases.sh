# Source generated aliases
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

alias ll="ls -l"

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Always enable colored `grep` output
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# Aliases for Tmux
alias ta='tmux attach -t'
alias tnew='tmux new -s'
alias tls='tmux ls'

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

# List Largest Files
alias largest_files='du -ah | sort -hr | head -n 10'

# List Largest Directories
alias largest_directories='du -sh * | sort -hr | head -n 10'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

alias noheader='tail -n +2'


# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

alias generate_password='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;'

alias beep="osascript -e 'beep 5'"

# AWS CDK
alias cdk1="npx aws-cdk@1.x"
alias cdk2"=npx aws-cdk@2.x"
alias cdk="npx aws-cdk@2.x"
alias ls_cdk="find . -type f -maxdepth 2 -name 'cdk.json' -exec dirname '{}' \;"



