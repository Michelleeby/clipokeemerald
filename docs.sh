function cli.docs.body() {
    local functions=$DECOMPS_CLI/cli.sh

    if [ ! -z "${1[@]}" ]; then
        functions=$1
    fi

    ###
    # awk BODY
    ###
    awk \
    -v maroon=$COLORS[maroon] \
    -v purple=$COLORS[purple] \
    -v grey=$COLORS[grey] \
    -v red=$COLORS[red] \
    -v fuchsia=$COLORS[fuchsia] \
    -v aqua=$COLORS[aqua] \
    -v white=$COLORS[white] \
    '\
    /@name/ \
    {
        print "\n" red $3, grey substr($0, index($0, $4))
    }
    /@arg/ \
    {
        print maroon $2, aqua $3, red $4, aqua $5,
        fuchsia substr($6, 1, 1) purple substr($6, 2, 2),
        white $7, grey substr($0, index($0, $8))
    }
    /@returns/ \
    {
        print maroon $2, grey substr($0, index($0, $3)),
        "\n"
    }' \
    $functions
}


# COLUMN has the following form:
# column[color]=$COLORS[color]      // The color to print this string.
# column[text]="foo"                // A single string


# TITLE has the following form:
# title[columns]=(col1 col2 ...)    // A list of columns that make up the whole text.
# title[wrapper]="😎"               // A character that bookends the columns.

function cli.docs.header() {
    declare -A header
    header[margin]=$PADDING[double]
    header[columns]="$COLORS[grey]Pokémon $COLORS[lime]CLI $COLORS[grey]tools"
    header[wrapper]="📖"
    header[gutter]=$PADDING[single]

    declare -A subheader
    subheader[margin]=$PADDING[single]
    subheader[gutter]=$PADDING[double]

    if [ ! -z "${1[@]}" ] && [ ! -z "${2[@]}" ]; then

        header[margin]=$subheader[margin]
        header[columns]=$1
        header[wrapper]=$2
        header[gutter]=$subheader[gutter]

    fi

    ###
    # awk HEADER
    ###
    awk \
    -v margin=$header[margin] \
    -v columns=$header[columns] \
    -v wrapper=$header[wrapper] \
    -v gutter=$header[gutter] \
    '\
    {
        print margin wrapper, columns, wrapper gutter
    }
    {
        exit;
    }' \
    <<< ""
}


function cli.docs() {
    declare -A functions
    functions=(
        [default]="usage"
        [verbose]="helpers"
    )

    local docs=$functions[default]

    cli.docs.header
    cli.docs.header "$COLORS[yellow]$docs documentation" "🛠️"
    cli.docs.body

    if [ ! -z "${1[@]}" ]; then
        docs=$functions[verbose]
        cli.docs.header "$COLORS[yellow]$docs documentation" "🚧🦺"
        cli.docs.body $DECOMPS_CLI/helpers.sh
    fi
}


function docs.color.printer() {
    declare -A colors

    colors[maroon]="\033[38;5;1m" # @descriptor
    colors[purple]="\033[38;5;5m" # "[ ]" and "{ }"
    colors[grey]="\033[38;5;8m" # descriptions
    colors[red]="\033[38;5;9m" # function name or { arg type }
    colors[lime]="\033[38;5;10m"
    colors[blue]="\033[38;5;12m"
    colors[fuchsia]="\033[38;5;13m"
    colors[aqua]="\033[38;5;14m"
    colors[white]="\033[38;5;255m" # arg name

    for name color in ${(kv)colors}; do
        awk -v color=$color \
        -v name=$name '{print color \
        name}' <<< "";
    done
}
