# Init the CLI environment.
printf "\n%s\n\n" "Initialiazing CLI tools for Pokémon decomp projects..."

# decomps.clone <github-repository> <project-path> : Clones a given repo into a given project path.
decomps.clone() {
    local gh_repo="$1"
    local project=$2

    git clone $gh_repo $project

    printf "Cloned %s into %s" $gh_repo $project
}

printf "\n%s\n" "✅ Initialized decomps.clone()..."

# decomps.init : Builds the C compiler in the env defined directory. 
decomps.init() {
    cd $DECOMPS_AGBCC
    ./build.sh
    printf "Initiliazed C Compiler found in %s, returning home." $DECOMPS_AGBCC
    cd ~ 
}

printf "\n%s\n" "✅ Initialized decomps.init()..."

# decomps.init.project <project-path> : Installs the compiler to the given project path.
decomps.init.project() {
    local project=$1

    cd $DECOMPS_AGBCC
    ./install.sh $project
    printf "Installed the compiler to %s, returning home." $project
    cd ~
}

printf "\n%s\n" "✅ Initialized decomps.init.project()..."

# decomps.new <github-repository-base> <project-name> : Clones and inits a new Pokémon decomp project with the given name.
decomps.new() {
    local repo="$1"
    local project_name="$2"
    local project_path=$DECOMPS_SOURCE_DIR/$project_name

    decomps.clone $repo $project_path
    decomps.init.project $project_path

    printf "Finished creating %s at %s." $project_name $project_path
}

printf "\n%s\n" "✅ Initialized decomps.new()..."

# decomps.make <project-name> <optional-clean-flag> : Given a project and optionally a clean flag, runs the make modern or make clean script.
decomps.make() {
    local project=$DECOMPS_SOURCE_DIR/"$1"
    local command=""

    cd $project

    if [ $# -eq 1 ]; then
        command="modern"
        make $command
    elif [ $# -eq 2 ]; then
        command="clean"
        make $command
    else
        printf "decomps.make expects 1 or 2 inputs, but was given %n." $#
    fi

    printf "Finished running make %s, returning home." $command
    cd ~
}

printf "\n%s\n" "✅ Initialized decomps.make()..."

# decomps.open <project-name> : Opens the given project is VS Code.
decomps.open() {
    local project=$DECOMPS_SOURCE_DIR/"$1"
    code $project
}

printf "\n%s\n\n" "✅ Initialized decomps.open()..."

# Prints brief CLI usage docs
cli.docs() {
    local padding="    "
    local hr="---"
    local path="<github-repository-path>"
    local name="<project-name>"

    printf -v header "📖 Pokémon decomp CLI tools usage docs 📖"
    printf -v new  "decomps.new  %s %s %s Clones and inits \n%sa new Pokémon decomp project with the given project name from \n%sthe given github repo." $path $name $hr $padding $padding
    printf -v open "decomps.open %s %s Given a project name, opens the \n%sproject's root directory in VS Code." $name $hr $padding
    printf -v make "decomps.make %s %s Given a project name, runs the make \n%smodern script on the appropriate project \n%sdirectory." $name $hr $padding $padding

    printf "\n%s\n\n%s%s\n\n%s%s\n\n%s%s\n\n" $header $padding $new $padding $open $padding $make
}


printf "\n%s\n\n%s\n%s\n\n" "🏁 Finished 🏁" "Pokémon decomp CLI tools initialized." "Run cli.docs for available functions."
