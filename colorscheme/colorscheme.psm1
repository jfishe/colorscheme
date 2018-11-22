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
        [switch] $Dark,

        [Parameter(Mandatory=$false)]
        [switch] $Light,

        [Parameter(Mandatory=$false)]
        [switch] $d
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
        }

    Process
    {
        If ($Dark) {
            $ColorToolScheme = "$PSScriptRoot\Solarized Dark Higher Contrast.itermcolors"
        }
        ElseIf ($Light) {
            $ColorToolScheme = "$PSScriptRoot\solarized_light.itermcolors"
        }
        Else {
            $ColorToolScheme = "$PSScriptRoot\solarized_dark.itermcolors"
        }
        Write-Verbose "You selected for the current session:`n         $ColorToolScheme"
        # $ColorTool = "C:\Users\fishe\Documents\GitHub\console\tools\ColorTool"
        $ColorTool = "$PSScriptRoot"
        # $ColorToolScheme = "$ColorTool\schemes\Solarized Dark Higher Contrast.itermcolors"
        # $ColorToolScheme = "C:\Users\fishe\Documents\GitHub\iTerm2-Color-Schemes\schemes\Solarized Dark Higher Contrast.itermcolors"

        $ColorToolExe = "$ColorTool\ColorTool.exe"


        & $ColorToolExe  $ColorToolScheme

        If ($d) {
            if ($PSCmdlet.ShouldProcess("Default Colorscheme")) {
                Write-Verbose "Default updated to $ColorToolScheme`n Don't forget to save Defaults"
                & $ColorToolExe  -d $ColorToolScheme
            }
        }

        # Set-PSReadlineOption -ResetTokenColors
        # Correct default tokens that don't change correctly for white background.
        # if ($Light) {
        #     $Colors = @{
        #         ContinuationPrompt = 'Black'
        #         Default = 'Black'
        #         Type = 'DarkGray'
        #         Member = 'Black'
        #         Number = 'Black'
        #     }
        #     Set-PSReadlineOption -Colors $Colors
        # }
    }
}
