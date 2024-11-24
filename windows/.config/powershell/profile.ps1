$env:PSModulePath += ";$HOME\Documents\PowerShell\Modules"
# Module Imports
Import-Module Microsoft.PowerShell.Management
Import-Module PSReadLine
Import-Module -Name Terminal-Icons

# Aliases
Set-Alias tt tree # tree view
Set-Alias g git # git commands
Set-Alias ll Get-DetailedChildRecursiveItem # list items with details
Set-Alias lsh Get-DetailedChildHiddenItem # list items with hiden items
Set-Alias cl clear # clear terminal
Set-Alias pn pnpm # pnpm commands
Set-Alias touch New-Item # create a new file
Set-Alias ml New-Directory # create a new directory
Set-Alias lf Get-FilesRecursive -Option AllScope
Set-Alias lfa Get-FilesRecursiveWithHidden -Option AllScope
Set-Alias vim nvim # vim
# Should manually invoke before this takes effect
Set-Alias tsync $PROFILE | Invoke-Expression # syncronise the profile with terminal
Set-Alias trstart Restart-Terminal

# Risky Aliases
Set-Alias rm Remove-Item # remove a file or directory
Set-Alias "rm -rf" Remove-ItemRecursively # remove a folder recursively
Set-Alias "sudo rm" sudo_rm # remove a folder or file with admin rights
Set-Alias "sudo rm -rf" sudo_rmrf # remove a folder or file recursively with admin rights


# Set Parameters
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PsFzfOption -Key Tab -Function Complete
# Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
# Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource History
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Promt
# oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config 'C:/Powershell/myprofile.omp.json' | Invoke-Expression
# oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/emodipt-extend.omp.json' | Invoke-Expression

# Custom functions

# function pwsh for the file path
function whereis ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# func to handle creating of new folder
Function New-Directory {
    param(
        [string]$Path
    )

    New-Item -Path $Path -ItemType Directory
}

# func pwsh to handle removal of folder with amdin rights
function sudo_rm {
    param(
        [string]$Path
    )

    if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Remove-Item $Path -Force
    } else {
        Write-Host "You do not have administrative privileges."
    }
}

# func pwsh to handle removal of foler recursively with admin rights
function sudo_rmrf {
    param(
        [string]$Path
    )

    if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Remove-Item $Path -Recurse -Force
    } else {
        Write-Host "You do not have administrative privileges."
    }
}

# func pwsh to handle getting itms recursively
# Function for listing items with dynamic flags
# Import PoshColor module for enhanced formatting and icons

# Function for listing items with dynamic flags
Function Get-DetailedChildRecursiveItem {
    param (
        [string]$Path = (Get-Location)
    )

    $items = Get-ChildItem -Path $Path -Force -Attributes !Hidden | Where-Object { -not $_.PSIsContainer }
    foreach ($item in $items) {
        Write-Host $item.FullName -ForegroundColor Gray
    }

    $subDirectories = Get-ChildItem -Path $Path -Directory -Force -Attributes !Hidden | Where-Object { $_.Name -ne "node_modules" }
    foreach ($subDirectory in $subDirectories) {
        Get-DetailedChildRecursiveItem -Path $subDirectory.FullName
    }
}

# func pwsh to handle getting itms recursively with admin rights
Function Get-DetailedChildHiddenItem {
    Get-ChildItem -Force -Hidden
}

# func pwsh to handle removing items recursively
Function Remove-ItemRecursively {
    Remove-Item -Recurse
}

function Get-FilesRecursive {
    [CmdletBinding()]
    param (
        [string]$Path = (Get-Location),
        [string]$Filter = "*"
    )

    Write-Host "Directory: $Path" -ForegroundColor "Green"
    Write-Host ""

    Write-Host "Mode                LastWriteTime     size    Name" -ForegroundColor "Cyan"
    Write-Host "----                -------------     ------  ----" -ForegroundColor "Cyan"

    $items = Get-ChildItem -Path $Path -Recurse -File -Filter $Filter -Force | Where-Object { -not $_.PSIsContainer -and $_.FullName -notlike "*\node_modules\*" -and $_.FullName -notlike "*\.*" }
    $colors = @('DarkRed', 'DarkGreen', 'DarkYellow', 'DarkBlue', 'DarkMagenta', 'DarkCyan', 'Gray')
    $currentColorIndex = 0
    $currentParent = $Path
    $isFirstIteration = $true

    foreach ($item in $items) {
        $parent = Split-Path -Path $item.FullName -Parent

        if ($parent -ne $currentParent) {
            if (-not $isFirstIteration) {
                Write-Host ""
                Write-Host "Mode                LastWriteTime     size   Name" -ForegroundColor "Cyan"
                Write-Host "----                -------------     ------ ----" -ForegroundColor "Cyan"
            }
            $currentColorIndex = ($currentColorIndex + 1) % $colors.Length
            Write-Host "$parent" -ForegroundColor "DarkGray"
            Write-Host ""
            $currentParent = $parent
            $isFirstIteration = $false
        }

        $mode = if ($item.Attributes -band [System.IO.FileAttributes]::Hidden) { "h" } else { "-" }
        $mode += if ($item.Attributes -band [System.IO.FileAttributes]::Directory) { "d" } else { "-" }
        $size = if ($item.Length -gt 1mb) { "{0,-8}" -f ("{0:N2}mb" -f ($item.Length / 1mb)) } else { "{0,-8}" -f ("{0:N2}kb" -f ($item.Length / 1kb)) }
        $name = "{0,-40}" -f $item.Name
        $lastWriteTime = "{0,-17}" -f $item.LastWriteTime
        Write-Host "$mode $lastWriteTime $size $name" -ForegroundColor $colors[$currentColorIndex]
    }
}

function Get-FilesRecursiveWithHidden {
    [CmdletBinding()]
    param (
        [string]$Path = (Get-Location),
        [string]$Filter = "*"
    )

    Write-Host "Directory: $Path" -ForegroundColor "Green"
    Write-Host ""

    Write-Host "Mode                LastWriteTime     size    Name" -ForegroundColor "Cyan"
    Write-Host "----                -------------     ------  ----" -ForegroundColor "Cyan"

    $items = Get-ChildItem -Path $Path -Recurse -File -Filter $Filter -Force | Where-Object { -not $_.PSIsContainer -and $_.FullName -notlike "*\node_modules\*" }
    $colors = @('DarkRed', 'DarkGreen', 'DarkYellow', 'DarkBlue', 'DarkMagenta', 'DarkCyan', 'Gray')
    $currentColorIndex = 0
    $currentParent = $Path
    $isFirstIteration = $true

    foreach ($item in $items) {
        $parent = Split-Path -Path $item.FullName -Parent

        if ($parent -ne $currentParent) {
            if (-not $isFirstIteration) {
                Write-Host ""
                Write-Host "Mode                LastWriteTime     size   Name" -ForegroundColor "Cyan"
                Write-Host "----                -------------     ------ ----" -ForegroundColor "Cyan"
            }
            $currentColorIndex = ($currentColorIndex + 1) % $colors.Length
            Write-Host "$parent" -ForegroundColor "DarkGray"
            Write-Host ""
            $currentParent = $parent
            $isFirstIteration = $false
        }

        $mode = if ($item.Attributes -band [System.IO.FileAttributes]::Hidden) { "h" } else { "-" }
        $mode += if ($item.Attributes -band [System.IO.FileAttributes]::Directory) { "d" } else { "-" }
        $size = if ($item.Length -gt 1mb) { "{0,-8}" -f ("{0:N2}mb" -f ($item.Length / 1mb)) } else { "{0,-8}" -f ("{0:N2}kb" -f ($item.Length / 1kb)) }
        $name = "{0,-40}" -f $item.Name
        $lastWriteTime = "{0,-17}" -f $item.LastWriteTime
        Write-Host "$mode $lastWriteTime $size $name" -ForegroundColor $colors[$currentColorIndex]
    }
}
