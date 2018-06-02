# Entrypoint for the artist client GUI
# Usage: ./artist_client.sh selection
#        where "selection" is one of the options below
# To print an error message, print to stderr and exit with a non-zero code. For example:
# >&2 echo "Assets haven't changed." && exit 1

# The cancel button was selected
if [ "$1" = "false" ]; then
    exit 0
fi

cd "${VIO_DIR}/scripts"
git checkout master
git pull

if [ "$1" = "Update art assets" ]; then
    ./ase_update.sh
elif [ "$1" = "Play stable version" ]; then
    ./run_game.sh
elif [ "$1" = "Play experimental version" ]; then
    git fetch origin experimental
    git checkout experimental
    git reset --hard origin/experimental
    git clean -fd
    ./run_game.sh
elif [ "$1" = "Check for client updates" ]; then
    exit 0 # since we've already pulled from master, we're all set
fi
