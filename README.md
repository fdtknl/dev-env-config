# dev-env-config

## Windows developer environment installer

This repository includes a Winget configuration file that installs a common Windows developer toolchain on a fresh machine.

### Prerequisites on a fresh Windows installation

Windows must have Winget available. On a new machine, install the Microsoft App Installer from the Microsoft Store if needed.

### Run it directly from GitHub

From an elevated PowerShell or Command Prompt terminal, run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -Command "$configPath = Join-Path $env:TEMP 'dev-env-config.winget.yaml'; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/fdtknl/dev-env-config/main/dev-env-config.winget.yaml' -OutFile $configPath; winget configure --file $configPath"
```

This pulls the Winget configuration directly from GitHub and applies it without requiring you to clone or manually download the file.

### One-step setup script

A Windows batch script is included to automate the full setup flow on a fresh Windows machine:

```cmd
setup-dev-env.cmd
```

Run it from an elevated Command Prompt. The script will:

- download the Winget configuration file
- apply the Winget configuration
- install the recommended VS Code extensions
- open Firefox pages for Enpass and uBlock Origin installation
- use nvm to install and select the latest LTS Node.js release

The configuration installs the following in a dependency-safe order:

- PowerShell
- Git
- nvm for Windows
- .NET SDK 8
- Visual C++ Redistributable (required by Visual Studio components)
- Visual Studio Code
- Visual Studio 2022 Community
- Neovim
- Docker CLI
- Docker Desktop
- Python 3.12
- Notepad++

### Notes

- The command should be run from an elevated terminal (Run as administrator).
- After installation, close and reopen your terminal so the updated PATH is loaded.
