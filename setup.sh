#!/bin/bash

# Configuration Setup Script
# Downloads and installs configuration files including .tmux.conf, .zshrc, .taskrc, and neofetch config
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

# Configuration files with their destination paths
declare -A CONFIG_FILES=(
    [".tmux.conf"]="$HOME/.tmux.conf"
    [".zshrc"]="$HOME/.zshrc"
    [".taskrc"]="$HOME/.taskrc"
    ["config.conf"]="$HOME/.config/neofetch/config.conf"
)

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

# Function to ask if user wants to install a specific file
ask_install_confirmation() {
    local filename="$1"
    local description="$2"
    echo -e "${BLUE}Install ${filename}?${NC}"
    echo "  Description: $description"
    read -p "Do you want to install this file? (Y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        return 1
    else
        return 0
    fi
}

# Function to backup existing file
backup_file() {
    local file="$1"
    local backup_file="${file}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$file" "$backup_file"
    print_status "Backed up existing file to $backup_file"
}

# Function to create directory if it doesn't exist
ensure_directory() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        print_status "Creating directory: $dir"
        mkdir -p "$dir"
    fi
}

# Function to get file description
get_file_description() {
    local filename="$1"
    case "$filename" in
        ".tmux.conf")
            echo "Tmux terminal multiplexer configuration with custom key bindings and styling"
            ;;
        ".zshrc")
            echo "Zsh shell configuration with Oh My Zsh, Powerlevel10k theme, and neofetch"
            ;;
        ".taskrc")
            echo "Taskwarrior task management configuration file"
            ;;
        "config.conf")
            echo "Neofetch system information display configuration"
            ;;
        *)
            echo "Configuration file"
            ;;
    esac
}

# Function to download and install a configuration file
install_config_file() {
    local filename="$1"
    local dest_path="$2"
    local source_url="${REPO_BASE_URL}/${filename}"

    # Ask user if they want to install this file
    local description=$(get_file_description "$filename")
    if ! ask_install_confirmation "$filename" "$description"; then
        print_warning "Skipping $filename"
        return 0
    fi

    print_status "Processing $filename..."

    # Ensure destination directory exists
    local dest_dir=$(dirname "$dest_path")
    ensure_directory "$dest_dir"

    # Check if file already exists
    if [[ -f "$dest_path" ]]; then
        if ask_confirmation "$dest_path"; then
            backup_file "$dest_path"
        else
            print_warning "Skipping $filename (file exists, user chose not to overwrite)"
            return 0
        fi
    fi

    # Download the file
    print_status "Downloading $filename from repository..."
    if command_exists curl; then
        if curl -fsSL "$source_url" -o "$dest_path"; then
            print_success "Successfully installed $filename to $dest_path"
        else
            print_error "Failed to download $filename"
            return 1
        fi
    elif command_exists wget; then
        if wget -q "$source_url" -O "$dest_path"; then
            print_success "Successfully installed $filename to $dest_path"
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
    print_success "Configuration files installation completed!"
    echo
    print_status "Post-installation instructions:"
    echo
    echo "📁 TMUX Configuration (.tmux.conf):"
    echo "   • Start a new tmux session or reload: tmux source-file ~/.tmux.conf"
    echo "   • Key bindings: Prefix changed to Ctrl-a, | and - for pane splitting"
    echo
    echo "🐚 ZSH Configuration (.zshrc):"
    echo "   • Install Oh My Zsh: https://ohmyz.sh/"
    echo "   • Install Powerlevel10k: git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k"
    echo "   • Install neofetch for system info banner"
    echo "   • Restart terminal or run: source ~/.zshrc"
    echo
    echo "📋 Taskwarrior Configuration (.taskrc):"
    echo "   • Install taskwarrior: apt install taskwarrior (Ubuntu/Debian) or brew install task (macOS)"
    echo "   • Configuration will be automatically loaded when you run 'task' command"
    echo
    echo "🎨 Neofetch Configuration (config.conf):"
    echo "   • Install neofetch: apt install neofetch (Ubuntu/Debian) or brew install neofetch (macOS)"
    echo "   • Run 'neofetch' to see your system information with custom styling"
    echo
    echo "🔧 General Dependencies:"
    echo "   • zsh (shell)"
    echo "   • tmux (terminal multiplexer)"
    echo "   • taskwarrior (task management)"
    echo "   • neofetch (system information)"
    echo "   • git (version control)"
    echo
    print_status "Enjoy your enhanced development environment! 🚀"
    echo
    print_status "For more information, visit: https://github.com/EvgeniiKlepilin/config-files"
}

# Function to show available files
show_available_files() {
    echo
    print_status "Available configuration files:"
    echo
    for filename in "${!CONFIG_FILES[@]}"; do
        local description=$(get_file_description "$filename")
        echo "  📄 $filename - $description"
    done
    echo
}

# Main execution
main() {
    echo -e "${BLUE}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║                 Configuration Setup Script                ║"
    echo "║                                                           ║"
    echo "║  This script will install configuration files from the    ║"
    echo "║  config-files repository to your system                   ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"

    show_available_files

    check_prerequisites

    echo
    print_status "Starting installation process..."
    echo "You will be prompted for each file individually."
    echo

    # Install each configuration file
    local failed_installs=0
    local installed_count=0
    local skipped_count=0

    for filename in "${!CONFIG_FILES[@]}"; do
        local dest_path="${CONFIG_FILES[$filename]}"
        echo "----------------------------------------"
        if install_config_file "$filename" "$dest_path"; then
            if [[ -f "$dest_path" ]]; then
                ((installed_count++))
            else
                ((skipped_count++))
            fi
        else
            ((failed_installs++))
        fi
        echo
    done

    # Show results summary
    echo "========================================"
    print_status "Installation Summary:"
    echo "  ✅ Successfully installed: $installed_count file(s)"
    echo "  ⏭️  Skipped: $skipped_count file(s)"
    if [[ $failed_installs -gt 0 ]]; then
        echo "  ❌ Failed: $failed_installs file(s)"
    fi
    echo

    if [[ $failed_installs -eq 0 ]]; then
        show_post_install_instructions
    else
        print_error "$failed_installs file(s) failed to install"
        print_status "Check the errors above and try running the script again."
        exit 1
    fi
}

# Run main function
main "$@"
