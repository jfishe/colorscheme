<#PSScriptInfo

.VERSION 0.1

.GUID b5e98ff4-086c-49f3-9108-852c28c79ef5

.AUTHOR jdfenw@gmail.com

.COMPANYNAME John D. Fisher

.COPYRIGHT Copyright (C) 2018  John D. Fisher

.TAGS

.LICENSEURI https://github.com/jfishe/colorscheme/blob/master/LICENSE

.PROJECTURI https://github.com/jfishe/colorscheme

.ICONURI

.EXTERNALMODULEDEPENDENCIES

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


#>

<#

.DESCRIPTION
 Wrapper for Microsoft console ColorTool

#>
param()

function Set-ColorScheme
{
<#
.Synopsis
Set console color scheme using Microsoft ColorTool

.Description
Change the current and/or default console color scheme using ColorTool.

Specify a colorscheme in INI or itermcolors format. The module assumes the color scheme is in the schemes/ directory installed with ColorTool, unless a path to the scheme is specified.

.Notes
Microsoft provides pre-built ColorTool binaries or you can build from source. See RELATED LINKS. Install any additional schemes in the schemes/ folder included with ColorTool.

The module assumes that ColorTool and schemes/ are installed in the same directory as $PROFILE or in $env:PATH.

.Link
https://github.com/jfishe/colorscheme/blob/master/docs/Set-ColorScheme.md

.Link
https://github.com/Microsoft/console/tree/master/tools/ColorTool
#>
  [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium', PositionalBinding=$false, DefaultParametersetName='Apply')]
  param(
    # Suppress output of color scheme table.
    [Parameter(Mandatory = $false,ParameterSetName='Apply')]
    [Parameter(Mandatory = $false,ParameterSetName='Xterm')]
    [switch]$Quiet,

    # Change current and default console color scheme.
    #
    # This does NOT save the properties automatically. For that, you'll need to open the properties sheet and hit "Ok".
    [Parameter(Mandatory = $false,ParameterSetName='Apply')]
    [switch]$Both,

    # Change default console color scheme.
    #
    # This does NOT save the properties automatically for the current console. For that, you'll need to open the properties sheet, select Defaults and hit "Ok".
    [Parameter(Mandatory = $true,ParameterSetName='Defaults')]
    [switch]$Defaults,

    # Change current color scheme and output ANSI escape sequences for use in WSL console.
    [Parameter(Mandatory = $true,ParameterSetName='Xterm')]
    [switch]$Xterm,

    # Display version
    [Parameter(Mandatory = $true,ParameterSetName='Version')]
    [switch]$Version,

    # Change current console color scheme.
    #
    # This does NOT save the properties automatically. For that, you'll need to open the properties sheet and hit "Ok".
    [Parameter(Position = 0,Mandatory = $true,ParameterSetName='Apply')]
    [Parameter(Position = 0,Mandatory = $true,ParameterSetName='Defaults')]
    [Parameter(Position = 0,Mandatory = $true,ParameterSetName='Xterm')]
    [string]$SchemeName,

    # Specify path to ColorTool
    [Parameter(Mandatory = $false)]
    [string]$Path = (Get-Item $PROFILE).Directory.FullName
  )

  begin {
    if (-not $PSBoundParameters.ContainsKey('Verbose')) {
      $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
    }
    if (-not $PSBoundParameters.ContainsKey('Confirm')) {
      $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
    }
    if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
      $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
    }
    Write-Verbose ('[{0}] Confirm={1} ConfirmPreference={2} WhatIf={3} WhatIfPreference={4}' -f $MyInvocation.MyCommand,$Confirm,$ConfirmPreference,$WhatIf,$WhatIfPreference)

    $ColorToolExe = "ColorTool.exe"
    try {
      Write-Verbose "Looking for ColorTool in $Path"
      $ColorTool = Get-Command "$Path\$ColorToolExe" -ErrorAction Stop
    } catch [System.Management.Automation.CommandNotFoundException] {
      Write-Verbose 'Looking for ColorTool in $env:PATH'
      $ColorTool = Get-Command "$ColorToolExe" -ErrorAction Stop
    } finally {
      Write-Verbose ('Found {0}' -f $ColorTool.Path)
    }

    if ($Schemes) {
      try {
        Write-Verbose "Looking for schemes in $Path\schemes"
          $ColorToolSchemes = Get-Item ('{0}\schemes' -f $Path) -ErrorAction Stop
      } catch [System.Management.Automation.ItemNotFoundException] {
        Write-Verbose "$_.Exception.Message"
          Write-Verbose "ColorTool default location does not exist. Supply the full path to scheme files. See ColorTool --help"
      }
    }
  }

  process {
    if ($Quiet) {
      $Parameters = "--quiet $Parameters"
    }
    if ($Both) {
      $Parameters = "--both $Parameters"
    }

    if ($Xterm) {
      $Parameters = "--xterm $Parameters"
    }

    if ($Defaults) {
      $Parameters = "--defaults $Parameters"
    }

    $ColorTool | Format-List | Out-String | write-verbose
      write-verbose "Parameters: $Parameters"
      if ($PSCmdlet.ShouldProcess("Change to color scheme: ${SchemeName}?")) {
        & $ColorTool $(' ' + $Parameters).Split() "$SchemeName"
      } else {
        & $ColorTool $(' ' + $Parameters).Split() "$SchemeName"
      }
  }
}

function Get-ColorScheme
{
<#
.Synopsis
Get current console color scheme using Microsoft ColorTool.

.Description
Display the current or available color schemes installed with ColorTool.

Output the current color scheme in ColorTool INI format.

.Notes
Microsoft provides pre-built ColorTool binaries or you can build from source. See RELATED LINKS. Install any additional schemes in the schemes/ folder included with ColorTool.

The module assumes that ColorTool and schemes/ are installed in the same directory as $PROFILE or in $env:PATH.

.Link
https://github.com/jfishe/colorscheme/blob/master/docs/Get-ColorScheme.md

.Link
https://github.com/Microsoft/console/tree/master/tools/ColorTool


#>
  [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium', PositionalBinding=$false, DefaultParametersetName='Current')]
  param(
    # Display help
    [Parameter(Mandatory = $true,ParameterSetName='Help')]
    [switch]$Help,

    # Display current color scheme
    [Parameter(Mandatory = $false,ParameterSetName='Current')]
    [switch]$Current,

    # Display available color schemes
    [Parameter(Mandatory = $true,ParameterSetName='Schemes')]
    [switch]$Schemes,

    # Display version
    [Parameter(Mandatory = $true,ParameterSetName='Version')]
    [switch]$Version,

    # Save current color scheme
    [Parameter(Mandatory = $true,ParameterSetName='Output')]
    [string]$Output,

    # Specify path to ColorTool
    [Parameter(Mandatory = $false)]
    [string]$Path = (Get-Item $PROFILE).Directory.FullName
  )

  begin {
    if ($PsCmdlet.ParameterSetName -eq 'Current') {
      $Current = $true
    }

    if (-not $PSBoundParameters.ContainsKey('Verbose')) {
      $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
    }
    if (-not $PSBoundParameters.ContainsKey('Confirm')) {
      $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
    }
    if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
      $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
    }
    Write-Verbose ('[{0}] Confirm={1} ConfirmPreference={2} WhatIf={3} WhatIfPreference={4}' -f $MyInvocation.MyCommand,$Confirm,$ConfirmPreference,$WhatIf,$WhatIfPreference)

    $ColorToolExe = "ColorTool.exe"
    try {
      Write-Verbose "Looking for ColorTool in $Path"
      $ColorTool = Get-Command "$Path\$ColorToolExe" -ErrorAction Stop
    } catch [System.Management.Automation.CommandNotFoundException] {
      Write-Verbose 'Looking for ColorTool in $env:PATH'
      $ColorTool = Get-Command "$ColorToolExe" -ErrorAction Stop
    } finally {
      Write-Verbose ('Found {0}' -f $ColorTool.Path)
    }

    if ($Schemes) {
      try {
        Write-Verbose "Looking for schemes in $Path\schemes"
          $ColorToolSchemes = Get-Item ('{0}\schemes' -f $Path) -ErrorAction Stop
      } catch [System.Management.Automation.ItemNotFoundException] {
        Write-Verbose "$_.Exception.Message"
          Write-Verbose "ColorTool default location does not exist. Supply the full path to scheme files. See ColorTool --help"
      }
    }
  }

  process {
    if ($Help) {
      Get-Help Get-ColorScheme
      $Parameters = '--help'
    } elseif ($Version) {
      $Parameters = '--version'
    } elseif ($Schemes) {
      $Parameters = '--schemes'
    } elseif ($Current) {
      $Parameters = '--current'
    } elseif ($Output) {
      $Parameters = '--output'
    }

    $ColorTool | Format-List | Out-String | write-verbose
      write-verbose "Parameters: $Parameters"
      if ($Output) {
        $OutputExists = Get-Item "$Output" -ErrorAction SilentlyContinue
          if ($OutputExists -and $PSCmdlet.ShouldProcess("Overwrite ${Output}?")) {
            write-verbose "Writing $Output."
              & $ColorTool $Parameters.Split() "$Output"
          } else {
            & $ColorTool $Parameters.Split() "$Output"
          }
      } else {
        & $ColorTool $Parameters.Split()
      }
  }
}
