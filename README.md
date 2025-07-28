# config-files

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell Script](https://img.shields.io/badge/Script-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-blue.svg)](https://github.com/EvgeniiKlepilin/config-files)
[![Tmux](https://img.shields.io/badge/Tmux-Configuration-orange.svg)](https://github.com/tmux/tmux)
[![Zsh](https://img.shields.io/badge/Zsh-Configuration-red.svg)](https://www.zsh.org/)
[![Taskwarrior](https://img.shields.io/badge/Taskwarrior-Configuration-purple.svg)](https://taskwarrior.org/)
[![Neofetch](https://img.shields.io/badge/Neofetch-Configuration-cyan.svg)](https://github.com/dylanaraps/neofetch)

A comprehensive collection of configuration files for local development tools including Zsh, Tmux, Taskwarrior, and Neofetch. This repository provides a quick way to set up a consistent and productive development environment across multiple machines.

## 📁 Configuration Files

### `.tmux.conf`
Tmux (Terminal Multiplexer) configuration file that enhances your terminal experience with:
- **Custom key bindings**: Prefix changed from `Ctrl-b` to `Ctrl-a`
- **Intuitive pane splitting**: Use `|` and `-` for horizontal and vertical splits
- **Mouse support**: Click to switch panes and resize them
- **Vim-style navigation**: Navigate panes with Alt+Arrow keys
- **Enhanced scrollback**: Increased history limit to 9,999,999 lines
- **Custom status bar**: Clean, informative status line with system stats and date/time
- **Color scheme**: Green and yellow themed interface
- **Window management**: Smart window switching and automatic renaming

### `.zshrc`
Zsh shell configuration file featuring:
- **Oh My Zsh integration**: Popular Zsh framework for enhanced functionality
- **Powerlevel10k theme**: Fast and customizable prompt theme
- **Git plugin**: Enhanced git command support and aliases
- **Smart editor selection**: Automatically uses nvim locally, vim over SSH
- **Neofetch banner**: System information display on terminal startup
- **Optimized for development**: Sensible defaults for coding workflows

### `.taskrc`
Taskwarrior configuration file for efficient task management:
- **Data location**: Tasks stored in `~/.task` directory
- **News updates**: Configured for Taskwarrior 3.4.1+
- **Theme support**: Multiple color themes available (commented options)
- **XDG compliance**: Optional XDG directory structure support
- **Extensible**: Easy to customize with additional themes and settings

### `config.conf` (Neofetch)
Neofetch system information display configuration with:
- **Comprehensive system info**: OS, kernel, uptime, packages, shell, and more
- **Hardware details**: CPU, GPU, memory usage with percentages
- **Customizable display**: Toggle various information sections on/off
- **Color themes**: Distro-based coloring with custom options
- **Progress bars**: Visual indicators for memory, disk, and CPU usage
- **ASCII art**: Automatic distro logo detection with fallback options
- **Network info**: Local and public IP address display

## 🚀 Quick Setup

### One-line installation:
```bash
curl -fsSL https://raw.githubusercontent.com/EvgeniiKlepilin/config-files/main/setup.sh | bash
```

### Manual download and run:
```bash
curl -fsSL https://raw.githubusercontent.com/EvgeniiKlepilin/config-files/main/setup.sh -o setup.sh
chmod +x setup.sh
./setup.sh
```

## 🛠️ What the Setup Script Does

The enhanced `setup.sh` script provides a safe and interactive way to install configuration files:

### Key Features:
- ✅ **Individual file selection**: Choose which configuration files to install
- ✅ **Interactive prompts**: Detailed descriptions and confirmation for each file
- ✅ **Automatic backup**: Creates timestamped backups of existing configurations
- ✅ **Directory creation**: Automatically creates necessary directories (e.g., `~/.config/neofetch/`)
- ✅ **Safety checks**: Verifies prerequisites and handles errors gracefully
- ✅ **Comprehensive guidance**: Detailed post-installation instructions
- ✅ **Support for multiple tools**: Download via `curl` or `wget`
- ✅ **Colored output**: Enhanced readability with color-coded messages

### Installation Process:
1. **Prerequisite verification**: Checks for required tools (`curl` or `wget`)
2. **File overview**: Shows all available configuration files with descriptions
3. **Individual selection**: Prompts for each file installation with detailed descriptions
4. **Conflict resolution**: Handles existing files with backup and overwrite options
5. **Directory management**: Creates required directories automatically
6. **Installation summary**: Provides detailed results and next steps

## 📋 Prerequisites

### Required:
- `curl` or `wget` (for downloading files)
- `bash` (for running the setup script)

### Application-Specific Requirements:

#### For Zsh Configuration (`.zshrc`):
- **Zsh**: Modern Unix shell
  ```bash
  # Ubuntu/Debian
  sudo apt install zsh
  
  # macOS (usually pre-installed)
  brew install zsh
  ```

- **Oh My Zsh**: Zsh framework
  ```bash
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```

- **Powerlevel10k**: Zsh theme
  ```bash
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  ```

#### For Tmux Configuration (`.tmux.conf`):
- **Tmux**: Terminal multiplexer
  ```bash
  # Ubuntu/Debian
  sudo apt install tmux
  
  # macOS
  brew install tmux
  ```

#### For Taskwarrior Configuration (`.taskrc`):
- **Taskwarrior**: Task management tool
  ```bash
  # Ubuntu/Debian
  sudo apt install taskwarrior
  
  # macOS
  brew install task
  ```

#### For Neofetch Configuration (`config.conf`):
- **Neofetch**: System information tool
  ```bash
  # Ubuntu/Debian
  sudo apt install neofetch
  
  # macOS
  brew install neofetch
  ```

## 🔧 Manual Installation

If you prefer to install files manually:

```bash
# Clone the repository
git clone https://github.com/EvgeniiKlepilin/config-files.git
cd config-files

# Copy configuration files
cp .tmux.conf ~/.tmux.conf
cp .zshrc ~/.zshrc
cp .taskrc ~/.taskrc

# Create neofetch config directory and copy config
mkdir -p ~/.config/neofetch
cp config.conf ~/.config/neofetch/config.conf

# Reload configurations (if applications are running)
tmux source-file ~/.tmux.conf  # If tmux is running
source ~/.zshrc                # For zsh
```

## 🎨 Customization

These configuration files are designed to work out of the box, but you can customize them:

- **Tmux**: Edit `~/.tmux.conf` and reload with `tmux source-file ~/.tmux.conf`
- **Zsh**: Edit `~/.zshrc` and reload with `source ~/.zshrc`
- **Taskwarrior**: Edit `~/.taskrc` - changes are automatically applied
- **Neofetch**: Edit `~/.config/neofetch/config.conf` and run `neofetch` to test

### Theme Customization:
- **Taskwarrior**: Uncomment desired theme lines in `.taskrc`
- **Neofetch**: Modify color schemes and displayed information in `config.conf`
- **Tmux**: Adjust colors and status bar components in `.tmux.conf`

## 🚀 Getting Started

After installation:

1. **Set Zsh as default shell** (if desired):
   ```bash
   chsh -s $(which zsh)
   ```

2. **Start using tools**:
   ```bash
   # Start tmux session
   tmux new-session -s main
   
   # Add your first task
   task add "Learn the new configuration setup"
   
   # Display system info
   neofetch
   ```

3. **Customize as needed**: Each configuration file is well-commented for easy customization

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs or issues
- Suggest new configuration improvements
- Submit pull requests with enhancements
- Share your customizations and use cases
- Add support for additional tools

### Development Setup:
```bash
git clone https://github.com/EvgeniiKlepilin/config-files.git
cd config-files
# Make changes and test locally
./setup.sh
```

## 🌟 Acknowledgments

- [Oh My Zsh](https://ohmyz.sh/) community for the amazing shell framework
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) for the beautiful prompt theme
- [Tmux](https://github.com/tmux/tmux) developers for the excellent terminal multiplexer
- [Taskwarrior](https://taskwarrior.org/) team for the powerful task management system
- [Neofetch](https://github.com/dylanaraps/neofetch) for the elegant system information display

---

**Happy coding and stay productive!** 🚀

*For questions, issues, or feature requests, please visit our [GitHub repository](https://github.com/EvgeniiKlepilin/config-files).*
