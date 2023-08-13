# My dotfiles

Welcome to my dotfiles repository! Here, you'll find all the essential configuration files that I use to set up my system for Python development and daily use. These dotfiles help me maintain a consistent and efficient workflow across different environments.

## Requirements

Before you proceed with the installation, ensure that you have the following prerequisites installed on your system:

- **git:**
  Version control system to clone the dotfiles repository.

## Installation

Follow the steps below to set up my dotfiles on your system:

1. Choose the appropriate bootstrap script for your system and run it. Use one of the following options:

   - **Debian WSL2:**

     ```bash
     wget -q https://raw.githubusercontent.com/musthafak/dotfiles/main/bootstrap_debian_wsl.sh -O - | bash
     ```

   - **Ubuntu WSL2:**

     ```bash
     wget -q https://raw.githubusercontent.com/musthafak/dotfiles/main/bootstrap_ubuntu_wsl.sh -O - | bash
     ```

   - **Ubuntu desktop:**

     ```bash
     wget -q https://raw.githubusercontent.com/musthafak/dotfiles/main/bootstrap_ubuntu_desktop.sh -O - | bash
     ```

   - **Fedora workstation:**

     ```bash
     wget -q https://raw.githubusercontent.com/musthafak/dotfiles/main/bootstrap_fedora_workstation.sh -O - | bash
     ```

2. Update the font cache for proper display of fonts:

   ```bash
   fc-cache -f -v
   ```

## Usage

Once the installation is complete, my dotfiles will be seamlessly integrated into your system. They include configurations for my preferred Python development environment, shell settings, text editor preferences, and other tools I use in my daily tasks.

Feel free to explore and modify these dotfiles according to your preferences. You can use `stow` to manage individual configurations, making it easy to keep your system in sync with any updates I make to this repository.

## Feedback and Contributions

I'm continuously improving my dotfiles to make them even more useful and robust. If you have any suggestions or want to contribute improvements, feel free to open an issue or submit a pull request on this repository.
