init.cli() {
    local env=$1/env.sh
    local helpers=$1/helpers.sh
    local cli=$1/cli.sh

    source $env
    source $helpers
    source $cli

    printf -v header "\n%s\n" "🏁 Finished 🏁"
    printf -v stat "\n%s\n" "Pokémon decomp CLI tools initialized."
    printf -v suggestion "%s\n\n" "Run cli.docs for available functions."
    printf "%s%s%s" $header $stat $suggestion
}

init.cli $1