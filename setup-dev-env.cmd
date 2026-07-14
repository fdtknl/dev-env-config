@echo off
setlocal EnableExtensions

set "SCRIPT_DIR=%~dp0"
set "CONFIG_PATH=%SCRIPT_DIR%dev-env-config.winget.yaml"
set "GITHUB_CONFIG_URL=https://raw.githubusercontent.com/FrisoDenijs/dev-env-config/main/dev-env-config.winget.yaml"

where powershell.exe >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
  echo PowerShell was not found. Please install it first.
  exit /b 1
)

if not exist "%CONFIG_PATH%" (
  echo Downloading Winget configuration...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%GITHUB_CONFIG_URL%' -OutFile '%CONFIG_PATH%'"
)

echo Applying Winget configuration...
winget configure --file "%CONFIG_PATH%"

echo Refreshing the shell environment...

where code >nul 2>nul
if %ERRORLEVEL% EQU 0 (
  echo Installing VS Code extensions...
  call code --install-extension ms-python.python
  call code --install-extension ms-azuretools.vscode-containers
  call code --install-extension ms-vscode.vscode-typescript-next
) else (
  echo VS Code CLI not found. Skipping extension installation.
)

where nvm >nul 2>nul
if %ERRORLEVEL% EQU 0 (
  echo Installing and using the latest LTS Node.js release via nvm...
  call nvm install lts
  call nvm use lts
) else (
  echo nvm was not found. Skipping Node.js setup.
)

echo Setup complete. Close and reopen your terminal if any tools were just installed.
