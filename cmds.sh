#
# Bash helpers. Source this to make it available in your shell: `$ source ./cmds.sh'
#

#URI='localhost:3000/items.json'
URI='http://median-price.herokuapp.com/items.json'

alias ber='bundle exec rspec'

function pgl() { alias pgl='psql median_dev -U median'; }
function dbl() { heroku run rake db:schema:load; }

# Push new unsold item
function ni() {
	[[ $# -ne 2 ]] && echo "Usage: ni <brand> <year>" && return 1
	curl -d "item[brand]='$1'&item[year]=$2" $URI
}

# List items
function items() { curl $URI; }

# Push new sold items
function load() {
	curl -d 'item[brand]=merc&item[year]=2011&item[paid]=14000' $URI
	curl -d 'item[brand]=merc&item[year]=2011&item[paid]=12000' $URI
	curl -d 'item[brand]=merc&item[year]=2012&item[paid]=16000' $URI
	curl -d 'item[brand]=merc&item[year]=2012&item[paid]=18000' $URI
	curl -d 'item[brand]=merc&item[year]=2013&item[paid]=19000' $URI
	curl -d 'item[brand]=bmw&item[year]=2011&item[paid]=14000' $URI
	curl -d 'item[brand]=bmw&item[year]=2011&item[paid]=12000' $URI
	curl -d 'item[brand]=bmw&item[year]=2012&item[paid]=16000' $URI
	curl -d 'item[brand]=bmw&item[year]=2012&item[paid]=18000' $URI
	curl -d 'item[brand]=bmw&item[year]=2013&item[paid]=19000' $URI
}
