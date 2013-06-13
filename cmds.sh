#
# Bash helpers. Source this to make it available in your shell: `$ source ./cmds.sh'
#

alias ber='bundle exec rspec'

function ni() {
	# n.b. assumes rails server is running...
	[[ $# -ne 2 ]] && echo "Usage: ni <brand> <year>" && return 1
	curl -v -d "item[brand]='$1'&item[year]=$2" localhost:3000/items.json
}
alias pgl='psql median_dev -U median'
