# @name decomps.clone Clones a new Pokémon decomp project with the given name.
# @arg { string } $1 project Name of the project to clone.
# @arg { string } $2 repo Path to GitHub repository to clone.
# @returns A cloned repository at the given project path.
decomps.clone() {
    local gh_repo=$2
    local project=$1

    git clone $gh_repo $project

    printf -v message "Cloned %s into %s" $gh_repo $project
    printf "\n%s\n\n" $message
}

printf "\n%s\n" "✅ Initialized decomps.clone()..."


# @name decomps.init Builds the C compiler in the env defined `agbcc` directory. 
# @returns A built C compiler in the `agbcc` directory.
decomps.init() {
    cd $DECOMPS_AGBCC
    ./build.sh
    
    printf -v message "Initiliazed C Compiler found in %s, returning to %s." $DECOMPS_AGBCC $DECOMPS_ROOT_DIR
    printf "\n%s\n\n" $message
    
    cd $DECOMPS_ROOT_DIR
}

printf "\n%s\n" "✅ Initialized helper decomps.init()..."


# @name decomps.init.project Installs a built `agbcc` compiler to the given project path.
# @arg { string } $1 project Path of the project to install the compiler in.
# @returns A project directory ready to build.
decomps.init.project() {
    local project=$1

    cd $DECOMPS_AGBCC
    ./install.sh $project
    
    printf -v message "Installed the compiler to %s, returning to %s." $project $DECOMPS_ROOT_DIR
    printf "\n%s\n\n" $message
    
    cd $DECOMPS_ROOT_DIR
}

printf "\n%s\n" "✅ Initialized helper decomps.init.project()..."


# @name decomps.copy.built Copies the built GBA image to the given project's built image directory.
# @arg { string } $1 name Name of the project to copy the built GBA image from.
# @returns The given projects built image copied to the env defined decomps image directory.
decomps.copy.built() {
    local name=$1
    local built_path=$DECOMPS_BUILT_DIR/$name

    if [ ! -d $built_path ]; then
        mkdir -p $built_path
    fi

    find . -name "*.gba" -maxdepth 1 -exec cp {} $built_path/$name.gba \;
    printf -v message "Copied built GBA image to %s" $built_path/$name.gba
    printf "\n%s\n\n" $message
}

printf "\n%s\n" "✅ Initialized helper decomps.copy.built()..."

