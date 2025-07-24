# config-files

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell Script](https://img.shields.io/badge/Script-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-blue.svg)](https://github.com/EvgeniiKlepilin/config-files)
[![Tmux](https://img.shields.io/badge/Tmux-Configuration-orange.svg)](https://github.com/tmux/tmux)
[![Zsh](https://img.shields.io/badge/Zsh-Configuration-red.svg)](https://www.zsh.org/)

A collection of configuration files for local development tools including Zsh and Tmux. This repository provides a quick way to set up a consistent development environment across multiple machines.

## 📁 Configuration Files

### `.tmux.conf`
Tmux (Terminal Multiplexer) configuration file that enhances your terminal experience with:
- **Custom key bindings**: Prefix changed from `Ctrl-b` to `Ctrl-a`
- **Intuitive pane splitting**: Use `|` and `-` for horizontal and vertical splits
- **Mouse support**: Click to switch panes and resize them
- **Vim-style navigation**: Navigate panes with Alt+Arrow keys
- **Enhanced scrollback**: Increased history limit to 9,999,999 lines
- **Custom status bar**: Clean, informative status line with date/time
- **Color scheme**: Green and yellow themed interface

### `.zshrc`
Zsh shell configuration file featuring:
- **Oh My Zsh integration**: Popular Zsh framework for enhanced functionality
- **Powerlevel10k theme**: Fast and customizable prompt theme
- **Git plugin**: Enhanced git command support and aliases
- **Smart editor selection**: Automatically uses nvim locally, vim over SSH
- **Neofetch banner**: System information display on terminal startup
- **Optimized for development**: Sensible defaults for coding workflows

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

The `setup.sh` script provides a safe and interactive way to install configuration files:

1. **Safety checks**: Verifies prerequisites and detects existing files
2. **Backup protection**: Creates timestamped backups of existing configurations
3. **Interactive prompts**: Asks for confirmation before overwriting files
4. **Error handling**: Graceful failure handling with clear error messages
5. **Post-install guidance**: Provides next steps and dependency information

### Features:
- ✅ Automatic backup of existing configuration files
- ✅ Interactive confirmation for overwrites
- ✅ Support for both `curl` and `wget`
- ✅ Colored output for better readability
- ✅ Comprehensive error handling
- ✅ Post-installation instructions

## 📋 Prerequisites

Before running the setup script, ensure you have:

### Required:
- `curl` or `wget` (for downloading files)
- `bash` (for running the setup script)

### Recommended for full functionality:
- **Zsh**: Modern Unix shell
  ```bash
  # Ubuntu/Debian
  sudo apt install zsh

  # macOS (usually pre-installed)
  brew install zsh
  ```

- **Tmux**: Terminal multiplexer
  ```bash
  # Ubuntu/Debian
  sudo apt install tmux

  # macOS
  brew install tmux
  ```

- **Oh My Zsh**: Zsh framework
  ```bash
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ```

- **Powerlevel10k**: Zsh theme
  ```bash
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  ```

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

# Reload configurations
tmux source-file ~/.tmux.conf  # If tmux is running
source ~/.zshrc                # For zsh
```

## 🎨 Customization

These configuration files are designed to work out of the box, but you can customize them:

- **Tmux**: Edit `~/.tmux.conf` and reload with `tmux source-file ~/.tmux.conf`
- **Zsh**: Edit `~/.zshrc` and reload with `source ~/.zshrc`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Share your own configuration improvements

## 🌟 Acknowledgments

- [Oh My Zsh](https://ohmyz.sh/) community for the amazing shell framework
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) for the beautiful prompt theme
- [Tmux](https://github.com/tmux/tmux) developers for the excellent terminal multiplexer

---

**Happy coding!** 🚀
