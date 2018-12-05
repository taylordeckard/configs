function git_insertions () {
	git log --author="$1" --oneline --shortstat | grep insertions | sed s/^.*changed,// | sed s/insertions.*$// | awk '{s += $1} END { print s }'
}

function loop () {
	while [ 1 ]; do
		result=$(eval $1);
		clear;
		echo $result;
		sleep 1;
		test $? -gt 128 && break;
	done
}

# meta
editFn () {
    if [ $# -eq 0 ]; then
        echo ERR
    else
        if [ $1 == "alias" ]; then
            vi ~/.bashrc
        else
            vi $1
        fi
    fi
}

kns() {
    # 1: namespace, if none given command prints out current namespace
    # 2: context (apollo-dev /use) defaults to coulthard
    if [[ -z $1 ]] ; then
        context=$(/usr/local/bin/kubectl config current-context)
        namespace=$(/usr/local/bin/kubectl config view | grep "cluster: $context" -A 1| grep namespace: | tr -d '[:space:]')
        namespace_clean="${namespace#namespace:}"
        echo $namespace_clean;
    else
        context=$2
        if [[ -z $context ]] ; then
            context=$(kubectl config current-context)
        fi
        kubectl config set-context $context --namespace=$1
    fi
}
kloglevel() {
    kubectl exec -it $1 -- ash -c "echo level=$2 > .loglevel"
}
kloglevelsh() {
    kubectl exec -it $1 -- sh -c "echo level=$2 > .loglevel"
}
kswitch() {
   k config use-context $1
}
krestart() {
    kpods | grep $1 | awk '{ print "delete pod " $1 }' | xargs -n 3 kubectl
}
ksecret() {
	k get secret $1 -o json | jq ".data[\"$1.json\"]" | sed s/\"// | base64 --decode | jq
}
nodePortForward() {     k exec $1 -- kill -sigusr1 1;     k port-forward $1 9229; }
# unix
killprocFn () {
    if [ $# -eq 0 ]; then
        echo Specify port to kill
    else
        lsof -t -i tcp:$1 | xargs kill -9
    fi
}
dockerNuke() {     docker stop $(docker ps -a -q);     docker rm $(docker ps -a -q) --force;     docker rmi $(docker images -q) --force; }
linter-switch () {
	if [ $# -eq 0 ]; then
		echo "specify web or node"
		return
	fi
	if [ $1 == "web" ]; then
		cp ~/.eslintrc.web.json ~/.eslintrc.json
	fi
	if [ $1 == "node" ]; then
		cp ~/.eslintrc.node.json ~/.eslintrc.json
	fi
	if [ $1 == "off" ]; then
		awk '{ if (NR == 24) printf "\""; else if (NR == 23) gsub("\"", ""); print $0; }' ~/.vimrc > ~/.tmpvimrc && mv ~/.tmpvimrc ~/.vimrc
	fi
	if [ $1 == "on" ]; then
		awk '{ if (NR == 23) printf "\""; else if (NR == 24) gsub("\"", ""); print $0; }' ~/.vimrc > ~/.tmpvimrc && mv ~/.tmpvimrc ~/.vimrc
	fi
}
title () {
	echo -n -e "\033]0;$1\007"
}
function iterm2_print_user_vars () {
    iterm2_set_user_var gitProjectDir $(basename $(git rev-parse --show-toplevel 2> /dev/null) 2> /dev/null)
}
kversion () {
	if [ $# -eq 0 ]; then
		echo "usage: kversion <version | \"stable\">"
		return
	fi
	if [ $1 = "stable" ]; then
		echo "installing stable version"
		sudo curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl > /usr/local/bin/kubectl
	else
		echo "installing $1"
		sudo curl -L https://storage.googleapis.com/kubernetes-release/release/v$1/bin/darwin/amd64/kubectl > /usr/local/bin/kubectl
	fi
	sudo chmod +x /usr/local/bin/kubectl
}

