init.cli() {
    local env=$1/env.sh
    local cli=$1/cli.sh

    source $env
    source $cli
}

init.cli $1