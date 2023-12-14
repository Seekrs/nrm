#!/bin/bash

# Install the dependencies
python3 -m pip install -Ur requirements.txt --break-system-packages || echo "Failed to install the dependencies" && exit 1

# Make executable
chmod +x ./nrm

# Create local bin directory 
mkdir -p $HOME/.local/bin

# Symlink the executable to the local bin directory
cp ./nrm $HOME/.local/bin/nrm || ln -s $(pwd)/nrm $HOME/.local/bin/nrm || echo "Failed to copy or symlink the executable to the local bin directory" && exit 1

# Add the local bin directory to the PATH
SHELL=$(echo $SHELL | xargs basename)
SHELLRC="$HOME/.bashrc"
if [ $SHELL == "zsh" ]; then
	SHELLRC="$HOME/.zshrc"
elif [ $SHELL == "fish" ]; then
	XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
	SHELLRC="$XDG_CONFIG_HOME/fish/config.fish"
fi
echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> $SHELLRC
