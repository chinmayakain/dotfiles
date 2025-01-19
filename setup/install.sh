#!/bin/bash

# Step 1: Install Nix
echo "Installing Nix..."
sh <(curl -L https://nixos.org/nix/install)

# Step 2: Source the profile to load Nix into the current shell
echo "Sourcing the profile to activate Nix..."

# Source the system-wide Nix profile
if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix.sh ]; then
  source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
else
  # If system-wide profile not found, fall back to the user profile
  echo "Could not find nix.sh at the default location, sourcing user profile..."
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

# Explicitly export NIX_PATH if it's not set (this is important for some Nix commands)
export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/master.tar.gz

if [ -n "$ZSH_VERSION" ]; then
 source ~/.zshrc
fi

# Step 2.5: Install xcode-select
echo "Installing Xcode Command Line Tools..."
xcode-select --install
while ! xcode-select -p &>/dev/null; do
 echo "Waiting for Xcode Command Line Tools installation..."
 sleep 5
done

# Step 3: Check Nix activation
echo "Checking Nix activation..."
nix-shell -p neofetch --run neofetch

# Step 4: Install and switch to Nix-Darwin with your flake
echo "Starting to use Nix and Nix-Darwin..."
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/dotfiles/nix#air --impure

# Step 5: Source the profile again to apply Nix-Darwin changes
# Source the system-wide Nix profile
if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix.sh ]; then
  source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
else
  # If system-wide profile not found, fall back to the user profile
  echo "Could not find nix.sh at the default location, sourcing user profile..."
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

# Step 6: Install Node.js with NVM
echo "Setting up Node.js with NVM..."
nvm install node

# Step 7: Install TPM (Tmux Plugin Manager)
echo "Installing TPM (Tmux Plugin Manager)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux new-session -d
tmux source ~/.tmux.conf
tmux kill-server

# Step 8: Refresh the shell without restarting it
echo "Refreshing shell session to apply changes..."
source ~/.zshrc

echo "Installation complete!"
