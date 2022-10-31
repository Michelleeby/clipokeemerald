# decomps.new <github-repository-base> <project-name> : Clones and inits a new Pokémon decomp project with the given name.
decomps.new() {
    local repo=$1
    local project_name=$2
    local project_path=$DECOMPS_SOURCE_DIR/$project_name

    decomps.clone $repo $project_path
    decomps.init.project $project_path
    printf -v message "Finished creating %s at %s." $project_name $project_path
    printf "\n%s\n\n" $message
}

printf "\n%s\n" "✅ Initialized decomps.new()..."


# decomps.make <project-name> <optional-clean-flag> : Given a project and optionally a clean flag, runs the make modern or make clean script.
decomps.make() {
    local name=$1
    local project=$DECOMPS_SOURCE_DIR/$name
    local command=""

    cd $project

    if [ $# -eq 1 ]; then
        command="modern"
        make $command
    elif [ $# -eq 2 ]; then
        command="clean"
        make $command
    else
        printf -v message "decomps.make expects 1 or 2 inputs, but was given %n." $#
        printf "\n%s\n\n" $message
    fi

    decomps.copy.built $name

    printf -v message "Finished running make %s, returning to %s." $command $DECOMPS_ROOT_DIR
    printf "\n%s\n\n" $message

    cd $DECOMPS_ROOT_DIR
}

printf "\n%s\n" "✅ Initialized decomps.make()..."


# decomps.open <project-name> : Opens the given project in VS Code.
decomps.open() {
    local project=$DECOMPS_SOURCE_DIR/$1
    code $project
}

printf "\n%s\n\n" "✅ Initialized decomps.open()..."


# decomps.play <project-name> : Opens the built project with system default emulator.
decomps.play() {
    local rom=$DECOMPS_BUILT_DIR/$1/$1.gba
    open $rom
}


# Prints brief CLI usage docs
cli.docs() {
    local green='\e[1;32m%s\e[m'
    local blue='\e[1;34m%s\e[m'
    local magenta='\e[1;35m%s\e[m'
    local cyan='\e[1;36m%s\e[m'
    
    printf -v cli_title $green "CLI"

    printf -v new_title $magenta "decomps.new"
    printf -v open_title $magenta "decomps.open"
    printf -v make_title $magenta "decomps.make"
    printf -v play_title $magenta "decomps.play"

    printf -v path_title $blue "<github-repository-path>"
    printf -v project_title $blue "<project-name>"
    printf -v flag_title $cyan "<optional-flag>"
    
    
    printf -v header_text "📖 Pokémon decomp %s tools usage docs 📖" $cli_title
    printf -v new_text  "
    Clones and inits a new Pokémon decomp project with 
    the given project name from the given github repo.
    "
    printf -v open_text "
    Given a project name, opens the 
    project's root directory in VS Code.
    "
    printf -v make_text "
    Given a project name and optionally a clean flag, 
    runs the appropriate make script on the 
    appropriate project directory.
    "

    printf -v play_text "
    Given a project name, opens the appropriate built 
    image in the system default emulator."

    printf -v header "\n%s\n\n" $header_text
    printf -v new "%s %s %s\n%s\n\n" $new_title $path_title $project_title $new_text
    printf -v open "%s %s\n%s\n\n" $open_title $project_title $open_text
    printf -v make "%s %s %s\n%s\n\n" $make_title $project_title $flag_title $make_text
    printf -v play "%s %s\n%s\n\n" $play_title $project_title $play_text

    printf "%s%s%s%s%s" $header $new $open $make $play
}

