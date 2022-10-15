ENV=$PWD/clipokeemerald/env.sh
CLI=$PWD/clipokeemerald/cli.sh

source $ENV
source $CLI

if [ ! -d $DECOMPS_ROOT_DIR ]; then
    mkdir -p $DECOMPS_ROOT_DIR
fi

printf "\n%s\n\n" "✅ Created decomps root directory."

if [ ! -d $DECOMPS_TOOLS_DIR ]; then
    mkdir -p $DECOMPS_TOOLS_DIR
fi

printf "\n%s\n\n" "✅ Created decomps tools directory."

cd $DECOMPS_ROOT_DIR
mv $PWD/clipokeemerald $DECOMPS_TOOLS_DIR/cli

printf "\n%s\n\n" "✅ CLI tool directory moved to decomps tools directory."

if [ ! -d $DECOMPS_AGBCC ]; then
    git clone https://github.com/pret/agbcc.git $DECOMPS_AGBCC
    decomps.init
    cd $DECOMPS_ROOT_DIR
fi

printf "\n%s\n\n" "✅ Installed agbcc C compiler @ $DECOMPS_AGBCC."


if [ ! -d $DECOMPS_SOURCE_DIR ]; then
    mkdir -p $DECOMPS_SOURCE_DIR
fi

printf "\n%s\n\n" "✅ Created decomps source directory."

printf -v path "%s/%s/%s.sh" $DECOMPS_TOOLS_DIR "cli" "init"
printf -v args "%s/%s" $DECOMPS_TOOLS_DIR "cli"
printf -v clipokeemerald '%s %s="%s %s %s"' "alias" "clipokeemerald" "source" $path $args

echo $clipokeemerald >> ~/.zshrc
source ~/.zshrc

printf "\n%s\n\n" "✅ Created clipokeemerald alias."

printf "\n%s\n\n%s\n\n" "🏁 Finished 🏁" "Run clipokeemerald to use."