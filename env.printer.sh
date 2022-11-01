declare -Ag COLORS

COLORS[maroon]="\033[38;5;1m"   # @descriptor
COLORS[purple]="\033[38;5;5m"   # "#" of positional argument
COLORS[grey]="\033[38;5;8m"     # descriptions
COLORS[red]="\033[38;5;9m"      # function name or type of "{ type }"
COLORS[lime]="\033[38;5;10m"    # "CLI" in "Pokémon CLI tools"
COLORS[yellow]="\033[38;5;11m"  # Subheaders
COLORS[blue]="\033[38;5;12m"    # unused
COLORS[fuchsia]="\033[38;5;13m" # "$" of positional argument
COLORS[aqua]="\033[38;5;14m"    # "{" and "}" of "{ type }"
COLORS[white]="\033[38;5;255m"  # arg name

declare -Ag PADDING

PADDING[double]="\n\n"
PADDING[single]="\n"