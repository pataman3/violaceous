# Entrypoint for the artist client GUI
# Usage: ./artist_client.sh selection
#        where "selection" is one of the options below

cd "${VIO_DIR}/scripts"
git checkout master
git pull

if [ "$1" = "Update art assets" ]; then
    ./ase_update.sh
elif [ "$1" = "Play stable version" ]; then
    ./run_game.sh
elif [ "$1" = "Play experimental version" ]; then
    git checkout experimental
    ./run_game.sh
elif [ "$1" = "Check for client updates" ]; then
    exit 0 # since we've already pulled from master, we're all set
fi
