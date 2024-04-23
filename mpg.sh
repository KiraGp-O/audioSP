#!/bin/bash

# Check if the file exists, if not, create it using touch
# Function to display help message
display_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --help           Display this help message"
    echo ""
    echo "Description:"
    echo "This script plays random audio files from the specified directory using mpv."
}

if [ $# -eq 0 ]; then
    echo 'start(-_è)'
fi

# Iterate over each argument
if [ "$1" = '--help' ]; then
    display_help
fi

if [ "$1" = '-s' ]; then
    killall mpv
    echo 'false' > $HOME/.mpg/subcashe
    rm $HOME/.mpv/subcashe
    killall mpv
    killall mpg
fi

sleep 1

if [ ! -x "$(command -v mpv)" ]; then
    sudo apt install -y mpv
    echo 'You need mpv to run the script'
fi

if [ ! -d "$HOME/.mpg/" ]; then
    mkdir -p $HOME/.mpg
fi

if [ ! -f "$HOME/.mpg/subcashe" ]; then
    echo 'false' > $HOME/.mpg/subcashe
fi
if [ ! -f "$HOME/.mpg/di.di" ]; then
	touch $HOME/.mpg/di.di
    echo ''$HOME'/Music' > $HOME/.mpg/di.di
    exit
else
	di=$(cat $HOME/.mpg/di.di)
fi
# Check the content of the file
if [ "$(cat $HOME/.mpg/subcashe)" = "false" ]; then
    while true; do
        echo 'true' > $HOME/.mpg/subcashe
        if pgrep -x "mpv" > /dev/null; then
            echo $(pgrep -x "mpv")
            gamemoderun mpv "$(find "$di" -type f | shuf -n 1)" --volume=25
        else
            gamemoderun mpv "$(find "$di" -type f | shuf -n 1)" --volume=100
        fi
        echo 'true' > $HOME/.mpg/subcashe
    done
else
	killall mpv
	rm $HOME/.mpg/subcashe
fi
