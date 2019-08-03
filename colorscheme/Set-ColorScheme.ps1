$colortool = Get-Command -Name "colortool"

Function Set-ColorScheme {

    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    Param(
      # [Parameter(Mandatory=$false)]
      # $Scheme
    )
      DynamicParam {
        # https://foxdeploy.com/2017/01/13/adding-tab-completion-to-your-powershell-functions/
        # Set the dynamic parameters' name
        $ParameterName = 'Scheme'

        # Create the dictionary
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

        # Create the collection of attributes
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]

        # Create and set the parameters' attributes
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $false
        # $ParameterAttribute.Position = 1

        # Add the attributes to the attributes collection
        $AttributeCollection.Add($ParameterAttribute)

        # Generate and set the ValidateSet
        # $arrSet = Get-WmiObject Win32_Service -ComputerName $computername | select -ExpandProperty Name
        $arrSet = $colortool.Path |
          ForEach-Object -Process {(Get-Item $_).Directory} |
          ForEach-Object -Process {Get-ChildItem $_ -Name "schemes/*.itermcolors"}
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)

        # Add the ValidateSet to the attributes collection
        $AttributeCollection.Add($ValidateSetAttribute)

        # Create and return the dynamic parameter
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
        return $RuntimeParameterDictionary
    }
    Begin {
      # Bind the parameter to a friendly variable
      $Scheme = $PsBoundParameters[$ParameterName]

      $colortool = Get-Command -Name "colortool"
      $ColorSchemes = $colortool.Path |
        ForEach-Object -Process {(Get-Item $_).Directory} |
        ForEach-Object -Process {Get-ChildItem $_ -Name "schemes/solarized.*"}
      $colorscheme = [int]$(($env:COLORSCHEME -eq 0))
      $ConfirmMessage = @("Change console color scheme to",
          $ColorSchemes[$colorscheme]
          )
    }
    Process {
        if ($PSCmdlet.ShouldProcess($ConfirmMessage)) {
            $env:COLORSCHEME = $colorscheme
            & $colortool --quiet $ColorSchemes[$env:COLORSCHEME]
        }
    }
<#
.SYNOPSIS

Toggle the console color scheme between solarized dark and light.

.DESCRIPTION

Windows Console ColorTool should be in $env:PATH.

The schemes\ folder should be in the same directory as ColorTool.exe.

The color schemes, based on vim-solarized8, were created using terminal.sexy.

.OUTPUTS

ColorTool.exe --quiet [[solarized.dark.itermcolors]|[solarized.light].itermcolors]

.LINK

https://github.com/Microsoft/console/tree/master/tools/ColorTool

.LINK

https://terminal.sexy/

.LINK

https://github.com/lifepillar/vim-solarized8

#>
}
Set-Alias -Name yob -Value Set-ColorScheme
