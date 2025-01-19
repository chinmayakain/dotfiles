#!/bin/bash

# Script to install and set up the development environment using Nix, Nix-Darwin, NVM, and TPM

# Make sure to run this script from your dotfiles repo

# Step 1: Install Nix
echo "Installing Nix..."
sh <(curl -L https://nixos.org/nix/install)

# Step 2: Source the profile to load Nix into the current shell
echo "Sourcing the profile to activate Nix..."
source ~/.nix-profile/etc/profile.d/nix.sh

# Step 3: Check Nix activation
echo "Checking Nix activation..."
nix-shell -p neofetch --run neofetch

# Step 4: Install and switch to Nix-Darwin with your flake
echo "Starting to use Nix and Nix-Darwin..."
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/nix#air --impure

# Step 5: Source the profile again to apply Nix-Darwin changes
echo "Sourcing profile to apply Nix-Darwin configuration..."
source ~/.nix-profile/etc/profile.d/nix.sh

# Step 6: Install Node.js with NVM
echo "Setting up Node.js with NVM..."
nvm install node

# Step 7: Install TPM (Tmux Plugin Manager)
echo "Installing TPM (Tmux Plugin Manager)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf

# Step 8: Refresh the shell without restarting it
echo "Refreshing shell session to apply changes..."
source ~/.zshrc

echo "Installation complete!"