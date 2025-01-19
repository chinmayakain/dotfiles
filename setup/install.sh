#!/bin/bash

# Script to install and set up the development environment using Nix, Nix-Darwin, NVM, and TPM

# Make sure to run this script from your dotfiles repo

# Step 1: Install Nix
echo "Installing Nix..."
sh <(curl -L https://nixos.org/nix/install)

# Step 2: Restart shell session to activate Nix
echo "Restarting shell session to activate Nix..."
exec $SHELL -l

# Step 3: Check Nix activation
echo "Checking Nix activation..."
nix-shell -p neofetch --run neofetch

# Step 4: Install and switch to Nix-Darwin with your flake
echo "Starting to use Nix and Nix-Darwin..."
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/nix#air --impure

# Step 5: Restart shell session to apply Nix-Darwin changes
echo "Restarting shell session to apply Nix-Darwin configuration..."
exec $SHELL -l

# Step 6: Install Node.js with NVM
echo "Setting up Node.js with NVM..."
nvm install node

# Step 7: Install TPM (Tmux Plugin Manager)
echo "Installing TPM (Tmux Plugin Manager)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# Step 8: Restart shell session to apply all changes
echo "Final restart of shell session..."
exec $SHELL -l

echo "Installation complete!"

