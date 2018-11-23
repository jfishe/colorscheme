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
Param()

Function Set-ColorScheme
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
    [cmdletbinding(SupportsShouldProcess, ConfirmImpact='Low')]
    Param(
        [Parameter(Mandatory=$false)]
        [switch] $Help,

        [Parameter(Mandatory=$false)]
        [switch] $Current,

        [Parameter(Mandatory=$false)]
        [switch] $Quiet,

        [Parameter(Mandatory=$false)]
        [switch] $Both,

        [Parameter(Mandatory=$false)]
        [switch] $Schemes,

        [Parameter(Mandatory=$false)]
        [switch] $Version,

        [Parameter(Mandatory=$false)]
        [Alias("Output")]
        [string] $OutputFile,

        [Parameter(Mandatory=$false)]
        [string] $Path = (Get-Item $PROFILE).Directory.FullName
    )

     Begin {
            if (-not $PSBoundParameters.ContainsKey('Verbose')) {
                $VerbosePreference = $PSCmdlet.SessionState.PSVariable.GetValue('VerbosePreference')
            }
            if (-not $PSBoundParameters.ContainsKey('Confirm')) {
                $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
            }
            if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
                $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
            }
            Write-Verbose ('[{0}] Confirm={1} ConfirmPreference={2} WhatIf={3} WhatIfPreference={4}' -f $MyInvocation.MyCommand, $Confirm, $ConfirmPreference, $WhatIf, $WhatIfPreference)

            # $ColorTool = (Get-Item $PROFILE).Directory
            write-verbose "$Path"
            $ColorToolExe = "ColorTool.exe"
            try {
                Write-Verbose "Looking for ColorTool in $Path"
                $ColorTool= Get-Command "$Path\$ColorToolExe" -ErrorAction Stop
            } catch [System.Management.Automation.CommandNotFoundException] {
                Write-Verbose 'Looking for ColorTool in $env:PATH'
                $ColorTool= Get-Command "$ColorToolExe" -ErrorAction Stop
            } Finally {
                write-verbose $ColorTool.Path
            }

            if (Get-Command "$ColorToolExe" -ErrorAction Stop) {
                $ColorToolExe = Get-Command "$ColorToolExe" | Resolve-Path
                $ColorToolPath = (Get-Item $ColorToolExe).Directory
                try {
                    $ColorToolSchemes = Get-Item "$ColorToolPath\schemes" -ErrorAction Stop
                } catch [System.Management.Automation.ItemNotFoundException] {
                    Write-Verbose "$_.Exception.Message"
                    Write-Verbose "ColorTool default location does not exist. Supply the full path to scheme files. See ColorTool --help"
                }
            }
        }

    Process
    {
        & $ColorTool --schemes
        # If ($Dark) {
        #     $ColorToolScheme = "$PSScriptRoot\Solarized Dark Higher Contrast.itermcolors"
        # }
        # ElseIf ($Light) {
        #     $ColorToolScheme = "$PSScriptRoot\solarized_light.itermcolors"
        # }
        # Else {
        #     $ColorToolScheme = "$PSScriptRoot\solarized_dark.itermcolors"
        # }
        # Write-Verbose "You selected for the current session:`n         $ColorToolScheme"

        # & $ColorToolExe  $ColorToolScheme

        # If ($d) {
        #     if ($PSCmdlet.ShouldProcess("Default Colorscheme")) {
        #         Write-Verbose "Default updated to $ColorToolScheme`n Don't forget to save Defaults"
        #         & $ColorToolExe  -d $ColorToolScheme
        #     }
        # }
    }
}

# Export-ModuleMember -Function Set-ColorScheme
