init.cli() {
    local root=$1
    local env=$root/env.sh
    local helpers=$root/helpers.sh
    local cli=$root/cli.sh
    local docs=$root/docs.sh
    
    source $env $root
    source $helpers
    source $docs
    source $cli

    local header="🏁 Finished 🏁"
    local stat="$COLORS[grey]Pokémon decomp $COLORS[lime]CLI $COLORS[grey]tools initialized."
    local suggestion="$COLORS[grey]Run $COLORS[red]cli.docs $COLORS[grey]or $COLORS[red]cli.docs -v $COLORS[grey]for available functions"

    ###
    # Finished message
    ##
    awk \
    -v header=$header \
    -v stat=$stat \
    -v suggestion=$suggestion \
    -v double=$PADDING[double] \
    -v single=$PADDING[single] \
    '\
    {
        print single header single
    }
    {
        print stat
    }
    {
        print suggestion double
    }
    ' \
    <<< ""
}

init.cli $1