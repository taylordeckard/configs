shopt -s expand_aliases

alias ls="/opt/coreutils/bin/ls"

alias git_timestamp='git show -s --format=%ci'
alias reload="source ~/.zshrc"

# CLI Analyzer
alias buildsasa='cd ~/git/CLI_Analyzer/ApolloSAStandalone; gulp --sa --osx64 --fs'
alias buildsasaprod='cd ~/git/CLI_Analyzer/ApolloSAStandalone; gulp --sa --osx64 --fs —prod'
alias run_sasa='cd ~/git/CLI_Analyzer/ApolloSAStandalone/build/standalone/staging; more package.json | jq ".window.toolbar = true" > package2.json; mv package2.json package.json; nw'

# kubernetes
alias k="kubectl"
alias kpods="k get pods"
alias kdeps="k get deployments"
alias kservs="k get services"
alias kinfo="printf \"\nDEPLOYMENTS:\n\"; k get deployments; printf \"\nPODS:\n\"; k get pods; printf \"\nSERVICES:\n\"; k get services;"
alias kdescp="k describe pod"
alias kdescd="k describe deployment"
alias kdescs="k describe service"
alias k8sbd="gulp --k8s; gulp k8s;"
alias k8sbd_qa="gulp --k8s --qa; gulp k8s;"

alias ktail="kubetail"
alias kdelete="k delete deployment"
alias p2_vm="ssh swtg-rtp-apollo-deploy-prd"
alias nfs="ssh core@coulthard-file"
alias aws_login="\$(aws --no-include-email ecr get-login)"

alias mongo-hs="mongod --dbpath ~/home-share_data --fork --syslog"

alias dc="docker-compose"
alias chrome="killall -9 'Google Chrome' || open /Applications/Google\\ Chrome.app --args --disable-web-security --user-data-dir=''"
alias jira="node /Users/tadeckar/git/jira-node-cli/bin/jira.js"
alias length="awk 'END { print NR }'"
alias please='sudo "$BASH" -c "$(history -p !!)"'
alias sbuild='docker run -v "`pwd`":/data containers.cisco.com/cway/apollo-swagger:latest > swagger.json'
alias srun='echo "running on http://localhost"; docker run -p 80:8080 -e SWAGGER_JSON=/data/swagger.json -v "`pwd`":/data swaggerapi/swagger-ui'

# python
alias py='python3'
alias pip='pip3'

# custom function aliases
alias edit=editFn
alias killport=killprocFn

# inkscape
alias fixInkscape='wmctrl -r Inkscape -e 0,2560,1440,1200,700'

alias awesomeo="imgcat ~/Pictures/Awesomo-0.png"
