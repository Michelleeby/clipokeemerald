# decomps.clone <github-repository> <project-path> : Clones a given repo into a given project path.
decomps.clone() {
    local gh_repo=$1
    local project=$2

    git clone $gh_repo $project

    printf -v message "Cloned %s into %s" $gh_repo $project
    printf "\n%s\n\n" $message
}

printf "\n%s\n" "✅ Initialized decomps.clone()..."


# decomps.init : Builds the C compiler in the env defined directory. 
decomps.init() {
    cd $DECOMPS_AGBCC
    ./build.sh
    
    printf -v message "Initiliazed C Compiler found in %s, returning to %s." $DECOMPS_AGBCC $DECOMPS_ROOT_DIR
    printf "\n%s\n\n" $message
    
    cd $DECOMPS_ROOT_DIR
}

printf "\n%s\n" "✅ Initialized helper decomps.init()..."


# decomps.init.project <project-path> : Installs the compiler to the given project path.
decomps.init.project() {
    local project=$1

    cd $DECOMPS_AGBCC
    ./install.sh $project
    
    printf -v message "Installed the compiler to %s, returning to %s." $project $DECOMPS_ROOT_DIR
    printf "\n%s\n\n" $message
    
    cd $DECOMPS_ROOT_DIR
}

printf "\n%s\n" "✅ Initialized helper decomps.init.project()..."


# decomps.copy.built <project-name> : Copies the built GBA image to the given project's built image directory.
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

