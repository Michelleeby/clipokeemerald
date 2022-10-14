# Very basic CLI tools for Pokemon Decomp projects.

# Init the CLI environment.
source $1/env.sh
printf "Initialiazing CLI tools for Pokemon decomp projects
...
"


# decomps.clone <github-repository> <project-path> : Clones a given repo into a given project path.
decomps.clone() {
    local gh_repo="$1"
    local project=$2

    git clone $gh_repo $project

    printf "Cloned %s into %s" $gh_repo $project
}

printf "Initialized decomps.clone()...
"

# decomps.init : Builds the C compiler in the env defined directory. 
decomps.init() {
    cd $DECOMPS_AGBCC
    ./build.sh
    printf "Initiliazed C Compiler found in %s, returning home." $DECOMPS_AGBCC
    cd ~ 
}

printf "Initialized decomps.init.compiler()...
"

# decomps.init.project <project-path> : Installs the compiler to the given project path.
decomps.init.project() {
    local project=$1

    cd $DECOMPS_AGBCC
    ./install.sh $project
    printf "Installed the compiler to %s, returning home." $project
    cd ~
}

printf "Initialized decomps.init.project()...
"

# decomps.new <github-repository-base> <project-name> : Clones and inits a new Pokemon decomp project with the given name.
decomps.new() {
    local repo="$1"
    local project_name="$2"
    local project_path=$DECOMPS_SOURCE_DIR/$project_name

    decomps.clone $repo $project_path
    decomps.init.project $project_path

    printf "Finished creating %s at %s." $project_name $project_path
}

printf "Initialized decomps.new()...
"

# decomps.make <project-name> : Given a project, runs the make modern script.
decomps.make() {
    local project=$DECOMPS_SOURCE_DIR/"$1"

    cd $project
    make modern
    printf "Finished running make modern, returning home."
    cd ~
}

printf "Initialized decomps.make()...
"


# Prints brief CLI usage docs
cli.docs() {
    local init="decomps.init --- Initializes a decomp root by building the C compiler in the appropriate directory."
    local new="decomps.new <github-repository-path> <project-name> --- Clones and inits a new Pokemon decomp project with the given project name from the given github repo."
    local make="decomps.make <project-name> --- Given a project name, runs the make modern script on the appropriate project directory."

    printf "Pokemon decomp CLI tools usage docs:\n%s\n%s\n%s\n" $init $new $make
}


printf "Done. Pokemon decomp CLI tools initialized. Run cli.docs for available functions."
