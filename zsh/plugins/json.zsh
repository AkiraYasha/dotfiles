# vim: ft=zsh

if [[ $(which node) != "" ]]; then
    alias jsonpretty='xargs -0 node -e "console.log(JSON.stringify(JSON.parse(process.argv[1]), null, 4));"'
elif [[ $(which python) != "" ]]; then
    alias jsonpretty='python -mjson.tool'
elif [[ $(which ruby) != "" ]]; then
    alias jsonpretty='ruby -e "require \"json\"; require \"yaml\"; puts JSON.parse(STDIN.read).to_yaml"'
fi
