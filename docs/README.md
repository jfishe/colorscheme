---
Module Name: colorscheme
Module Guid: 9f65ec14-bdb8-41b4-99ea-26e763ff139a
Download Help Link:
Help Version: 0.2.0.0
Locale: en-US
---

# colorscheme Module

## Description

Colorscheme wraps Microsoft console ColorTool to provide a convenient path to
the executable and the associated schemes/ directory.

The functions look in the directory associated with $PROFILE or in $env:PATH,
if not found, for both ColorTool and the schemes/ directory.

## colorscheme Cmdlets

### [Get-ColorScheme](Get-ColorScheme.md)

Get-ColorScheme wraps ColorTool options that report on the current color scheme
or list available color schemes.

Get-ColorScheme can also output the current color scheme as an INI file.

### [Set-ColorScheme](Set-ColorScheme.md)

Set-ColorScheme wraps ColorTool options that change either the current and/or
default color schemes, including emitting ANSI escape sequences to a WSL
console.
