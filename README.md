# clipokeemerald
Utility scripts for Pokémon decomp projects.

## Getting started ( macOS )

Download and install clipokeemerald:

```bash
git clone git@github.com:Michelleeby/clipokeemerald.git && sh clipokeemerald/install.sh
```

Init the CLI in the shell:
```bash
clipokeemerald
```

Run the docs command for available usage:
```bash
cli.docs
```

## Basic usage notes
Assumes (and installs) the following project structure in the users home directory:

```
decomps
|--- tools
|--- --- cli
|--- --- agbcc
|--- source
|--- --- ...
```

The install script will look to see if any of these directories already exist. If `agbcc` does not exist, it will `git clone` into the appropriate directory and then the build script is run on it. If other directories do not exist, they will be created. Regardless of where the CLI is intially cloned, the CLI is moved to `/decomps/tools/cli`. Project source repositories are stored `/decomps/source/<project-name>`.