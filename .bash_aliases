###  Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

###  Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias g="git"
alias h="history"
alias j="jobs"
alias edit='$EDITOR'
alias qq='exit'

###  Clear screen with 0/CLR/clr or reset fucky terminal with 000
alias 0="clear"
alias CLR="clear"
alias clr="clear"
alias 000="reset"

###  Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
else # OS X `ls`
	colorflag="-G"
fi

###  Tree
if [ ! -x "$(which tree 2>/dev/null)" ]
then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

###  bd alias c
alias bd=". bd -s"
###  colorized cat output ( see http://www.markbadolato.com/blog/2013/12/22/colorized-cat-output/ )
alias ccat="pygmentize -O console256 -g"

###  List all files colorized in long format
alias l="ls -lF ${colorflag}"

###  List all files in long format, incl. dot files - colorized output
alias ll="ls -alF ${colorflag}"

###  List all files colorized in long format, including dot files
alias la="ls -laF ${colorflag}"

###  List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"

###  Always use color output for `ls` .. sexy-like theme
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

###  Enable aliases to be sudo’ed
alias sudo='sudo '

###  Get week number
alias week='date +%V'

###  Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

###  IP addresses
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

###  Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

###  Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

###  URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

###  Intuitive map function
###  For example, to list all directories that contain a certain file:
###  find . -name .gitattributes | map dirname
alias map="xargs -n1"

###  One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "$method"="lwp-request -m '$method'"
done

###  Vagrant stůff
alias vp='vagrant provision' 
alias vup='vagrant up'
alias vssh='vagrant ssh'
alias vdstr='vagrant destroy'
alias vll='vagrant list'
alias vss='vagrant status'

###  Docker stůff
alias dklc='docker ps -l'  # List last Docker container
alias dklcid='docker ps -l -q'  # List last Docker container ID
alias dklcip="docker inspect `dklcid` | grep IPAddress | cut -d '\"' -f 4"  # Get IP of last Docker container
alias dkps='docker ps'  # List running Docker containers
alias dkpsa='docker ps -a'  # List all Docker containers
alias dki='docker images'  # List Docker images
alias dkrmac='docker rm $(docker ps -a -q)'  # Delete all Docker containers
alias dkrmlc='docker-remove-most-recent-container'  # Delete most recent (i.e., last) Docker container
alias dkrmui='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'  # Delete all untagged Docker images
alias dkrmli='docker-remove-most-recent-image'  # Delete most recent (i.e., last) Docker image
alias dkrmi='docker-remove-images'  # Delete images for supplied IDs or all if no IDs are passed as arguments
alias dkideps='docker-image-dependencies'  # Output a graph of image dependencies using Graphiz
alias dkre='docker-runtime-environment'  # List environmental variables of the supplied image ID
alias dkelc='docker exec -it `dklcid` bash' # Enter last container (works with Docker 1.3 and above)

###  Ansible
alias ans='ansible'
alias ap='ansible-playbook'

###  Other
alias wleech='wget --mirror --continue --no-check-certificate --no-parent --recursive' # download content of the directory

###
### Linux specific stůff
if [ $(uname) == "Linux" ]
then
	if which yum > /dev/null 2>&1
	then
		alias yuc='yum check-update'
		alias yuu='sudo yum update'
		alias yca='sudo yum clean all'
		alias update='sudo yum update'
	elif which apt-get > /dev/null/ 2>&1
	then
		alias apu='sudo apt-get update && sudo apt-get -u upgrade'
	fi
	
	alias sha2sum='sha256sum'
	
fi

###
### OSX specific stůff
if [ $(uname) == "Darwin" ]
then

	###  View HTTP traffic OSX stuff
	###  sniff == tap0 (openvpn); sniffi == utun0 (work); sniff0 == en0 (ethernet); sniff1 == en1 (wifi)
	alias sniff="sudo ngrep -d 'tap0' -t '^(GET|POST) ' 'tcp and port 80'"
	alias sniffi="sudo ngrep -d 'utun0' -t '^(GET|POST) ' 'tcp and port 80'"
	alias sniff0="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
	alias sniff1="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"

	###  Lock the screen (when going AFK)
	alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

	###  Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
	alias update='sudo softwareupdate -i -a; brew update; brew upgrade --all; brew cleanup'

	###  Flush Directory Service cache
	alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

	###  Clean up LaunchServices to remove duplicates in the “Open With” menu
	alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

	###  Trim new lines and copy to clipboard
	alias c="tr -d '\n' | pbcopy"

	###  Stuff I never really use but cannot delete either because of http://xkcd.com/530/
	alias stfu="osascript -e 'set volume output muted true'"
	alias pumpitup="osascript -e 'set volume 5'"

	###  Kill all the tabs in Chrome to free up memory
	###  [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
	alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

	### Reload the shell (i.e. invoke as a login shell)
	alias reload="exec $SHELL -l"
	
	###  Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
	###  (useful when executing time-consuming commands)
	alias badge="tput bel"
	

	###  OS X has no `md5sum`, so use `md5` as a fallback
	command -v md5sum > /dev/null || alias md5sum="md5"
	###  OS X has no `sha1sum`, so use `shasum` as a fallback
	command -v sha1sum > /dev/null || alias sha1sum="shasum"
	###  OS X has no `sha256sum`, so use `shasumz as a fallback
	command -v sha256sum > /dev/null || alias sha256sum="shasum -a 256"

	###  Show/hide hidden files in Finder
	alias showhf="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
	alias hidehf="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

	###  Hide/show all desktop icons (useful when presenting)
	alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
	alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
	
	###  Merge PDF files
	###  Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
	alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'
	
	###  Disable Spotlight
	alias spotoff="sudo mdutil -a -i off"
	###  Enable Spotlight
	alias spoton="sudo mdutil -a -i on"

fi
