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
Set the console color scheme to dark or light and save color scheme to defaults
if desired.

.Description
The default is dark without updating the console color scheme defaults.

If -d is selected, the color scheme is written to the console defaults. To
save the defaults for future sessions, select Properties and OK and select
Defaults and OK from the console menu.

.Notes
Microsoft provides pre-built binaries or you can build from source. See RELATED LINKS.

.Link
https://github.com/Microsoft/console/tree/master/tools/ColorTool
#>
  [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium', PositionalBinding=$false, DefaultParametersetName='current')]
  param(
    # Display help
    [Parameter(Mandatory = $true,ParameterSetName='help')]
    [switch]$Help,

    # Display current color scheme
    [Parameter(Mandatory = $true,ParameterSetName='current')]
    [switch]$Current,

    [Parameter(Mandatory = $false,ParameterSetName='apply')]
    [Parameter(Mandatory = $false,ParameterSetName='xterm')]
    [switch]$Quiet,

    [Parameter(Mandatory = $false,ParameterSetName='apply')]
    [switch]$Both,

    [Parameter(Mandatory = $true,ParameterSetName='default')]
    [switch]$Defaults,

    [Parameter(Mandatory = $true,ParameterSetName='xterm')]
    [switch]$Xterm,

    # Display available color schemes
    [Parameter(Mandatory = $true,ParameterSetName='schemes')]
    [switch]$Schemes,

    # Display version
    [Parameter(Mandatory = $true,ParameterSetName='version')]
    [switch]$Version,

    # Save current color scheme
    [Parameter(Mandatory = $true,ParameterSetName='output')]
    [string]$Output,

    [Parameter(Position = 0,Mandatory = $true,ParameterSetName='apply')]
    [Parameter(Position = 0,Mandatory = $true,ParameterSetName='default')]
    [Parameter(Position = 0,Mandatory = $true,ParameterSetName='xterm')]
    [string]$SchemeName,

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
    if ($Help) {
      Get-Help Set-ColorScheme
      $Parameters = '--help'
    } elseif ($Version) {
      $Parameters = '--version'
    } elseif ($Schemes) {
      $Parameters = '--schemes'
    } elseif ($Current) {
      $Parameters = '--current'
    } elseif ($SchemeName) {
      $Parameters = "$SchemeName"
    }

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

      $Item = $ColorTool | Format-List | Out-String | write-verbose
      write-verbose "Parameters: $Parameters"
  }
}

function Get-ColorScheme
{
<#
.Synopsis
Set the console color scheme to dark or light and save color scheme to defaults
if desired.

.Description
The default is dark without updating the console color scheme defaults.

If -d is selected, the color scheme is written to the console defaults. To
save the defaults for future sessions, select Properties and OK and select
Defaults and OK from the console menu.

.Notes
Microsoft provides pre-built binaries or you can build from source. See RELATED LINKS.

.Link
https://github.com/Microsoft/console/tree/master/tools/ColorTool
#>
  [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium', PositionalBinding=$false)]
  param(
    # Display help
    [Parameter(Mandatory = $true,ParameterSetName='help')]
    [switch]$Help,

    # Display current color scheme
    [Parameter(Mandatory = $true,ParameterSetName='current')]
    [switch]$Current,

    # Display available color schemes
    [Parameter(Mandatory = $true,ParameterSetName='schemes')]
    [switch]$Schemes,

    # Display version
    [Parameter(Mandatory = $true,ParameterSetName='version')]
    [switch]$Version,

    # Save current color scheme
    [Parameter(Mandatory = $true,ParameterSetName='output')]
    [string]$Output,

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
    if ($Help) {
      Get-Help Set-ColorScheme
      $Parameters = '--help'
    } elseif ($Version) {
      $Parameters = '--version'
    } elseif ($Schemes) {
      $Parameters = '--schemes'
    } elseif ($Current) {
      $Parameters = '--current'
    } elseif ($Output) {
      $Parameters = "--output $Output"
    }

    $ColorTool | Format-List | Out-String | write-verbose
      write-verbose "Parameters: $Parameters"
      if ($Output) {
        $OutputExists = Get-Item "$Output" -ErrorAction SilentlyContinue
      }
    if ($OutputExists -and $PSCmdlet.ShouldProcess("Overwrite ${Output}?")) {
      write-verbose "Writing $Output."
        & $ColorTool $Parameters.Split()
    } else {
      & $ColorTool $Parameters.Split()
    }
  }
}

