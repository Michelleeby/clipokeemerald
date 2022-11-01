# @name decomps.new Clones and inits a new Pokémon decomp project with the given name.
# @arg { string } $1 project_name Name of the project to create.
# @arg { string } $2 repo Path to GitHub repository to clone.
# @returns A cloned and initilialized project that is ready to build.
decomps.new() {
    local project_name=$1
    local repo=$2
    local project_path=$DECOMPS_SOURCE_DIR/$project_name

    decomps.clone $repo $project_path
    decomps.init.project $project_path
    printf -v message "Finished creating %s at %s." $project_name $project_path
    printf "\n%s\n\n" $message
}

printf "\n%s\n" "✅ Initialized decomps.new()..."


# @name decomps.make Given a project (and optionally) a clean flag, runs the make modern or make clean script.
# @arg { string } $1 name Name of the project to make.
# @arg { mixed } $2 clean Sets whether to make clean. Accepts any value. 
# @returns A built image or a cleaned project. 
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


# @name decomps.open Opens the given project in VS Code. Assumes `code` command is set in $PATH.
# @arg { string } $1 name The name of the project to open.
# @returns The project opened in VS code at the projects root directory.
decomps.open() {
    local project=$DECOMPS_SOURCE_DIR/$1
    code $project
}

printf "\n%s\n\n" "✅ Initialized decomps.open()..."


# @name decomps.play Opens the built project with the system's default emulator.
# @arg { string } $1 name The name of the project image to open.
# @returns The game ready to play.
decomps.play() {
    local rom=$DECOMPS_BUILT_DIR/$1/$1.gba
    open $rom
}

