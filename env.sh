function init.env() {
    local cli_path=$1
    local printer=$cli_path/env.printer.sh
    local routes=$cli_path/env.routes.sh

    source $printer
    source $routes
}

init.env $1