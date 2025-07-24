#!/bin/bash

# Configuration Setup Script
# Downloads and installs .tmux.conf and .zshrc configuration files
# Author: Evgenii Klepilin
# Repository: https://github.com/EvgeniiKlepilin/config-files

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_BASE_URL="https://raw.githubusercontent.com/EvgeniiKlepilin/config-files/main"
HOME_DIR="$HOME"
CONFIG_FILES=(".tmux.conf" ".zshrc")

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to ask user for confirmation
ask_confirmation() {
    local file="$1"
    echo -e "${YELLOW}File ${file} already exists.${NC}"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to backup existing file
backup_file() {
    local file="$1"
    local backup_file="${file}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$file" "$backup_file"
    print_status "Backed up existing file to $backup_file"
}

# Function to download and install a configuration file
install_config_file() {
    local filename="$1"
    local source_url="${REPO_BASE_URL}/${filename}"
    local dest_path="${HOME_DIR}/${filename}"

    print_status "Processing $filename..."

    # Check if file already exists
    if [[ -f "$dest_path" ]]; then
        if ask_confirmation "$dest_path"; then
            backup_file "$dest_path"
        else
            print_warning "Skipping $filename"
            return 0
        fi
    fi

    # Download the file
    print_status "Downloading $filename from repository..."
    if command_exists curl; then
        if curl -fsSL "$source_url" -o "$dest_path"; then
            print_success "Successfully installed $filename"
        else
            print_error "Failed to download $filename"
            return 1
        fi
    elif command_exists wget; then
        if wget -q "$source_url" -O "$dest_path"; then
            print_success "Successfully installed $filename"
        else
            print_error "Failed to download $filename"
            return 1
        fi
    else
        print_error "Neither curl nor wget is available. Cannot download files."
        return 1
    fi
}

# Function to check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."

    if ! command_exists curl && ! command_exists wget; then
        print_error "Neither curl nor wget is installed. Please install one of them first."
        exit 1
    fi

    # Check if running in supported shell
    if [[ -z "$BASH_VERSION" ]]; then
        print_warning "This script is designed for bash. Some features might not work correctly."
    fi

    print_success "Prerequisites check passed"
}

# Function to provide post-installation instructions
show_post_install_instructions() {
    echo
    print_success "Configuration files have been installed successfully!"
    echo
    print_status "Next steps:"
    echo "  1. For tmux configuration to take effect:"
    echo "     - Start a new tmux session or run: tmux source-file ~/.tmux.conf"
    echo
    echo "  2. For zsh configuration to take effect:"
    echo "     - Make sure you have Oh My Zsh installed: https://ohmyz.sh/"
    echo "     - Install Powerlevel10k theme: https://github.com/romkatv/powerlevel10k"
    echo "     - Install neofetch for the system info banner"
    echo "     - Restart your terminal or run: source ~/.zshrc"
    echo
    echo "  3. Dependencies that may need to be installed:"
    echo "     - zsh (if not already your default shell)"
    echo "     - tmux"
    echo "     - Oh My Zsh framework"
    echo "     - Powerlevel10k theme"
    echo "     - neofetch"
    echo
    print_status "Enjoy your new configuration! 🚀"
}

# Main execution
main() {
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                 Configuration Setup Script                ║"
    echo "║                                                           ║"
    echo "║  This script will install .tmux.conf and .zshrc files     ║"
    echo "║  to your home directory from the config-files repository  ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo

    check_prerequisites

    # Install each configuration file
    local failed_installs=0
    for config_file in "${CONFIG_FILES[@]}"; do
        if ! install_config_file "$config_file"; then
            ((failed_installs++))
        fi
        echo
    done

    # Show results
    if [[ $failed_installs -eq 0 ]]; then
        show_post_install_instructions
    else
        print_error "$failed_installs file(s) failed to install"
        exit 1
    fi
}

# Run main function
main "$@"
