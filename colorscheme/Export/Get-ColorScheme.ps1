<#PSScriptInfo

.VERSION 1.0

.GUID 97a77855-1a24-4d76-9341-510a388fc446

.AUTHOR jdfenw@gmail.com

.COMPANYNAME John D. Fisher

.COPYRIGHT (c) 2018  John D. Fisher

.TAGS 

.LICENSEURI https://github.com/jfishe/colorscheme/blob/master/LICENSE.md

.PROJECTURI https://github.com/jfishe/colorscheme

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


#>

<#
.SYNOPSIS

  List available Itermcolors files for use with `colortool` or Set-ColorScheme

.DESCRIPTION

  Windows Console ColorTool should be in $env:PATH.

  The schemes\ folder should be in the same directory as ColorTool.exe.

.OUTPUTS

  [System.Arrary[String]]
  Available Itermcolors files for use with `colortool` or Set-ColorScheme

.LINK

  https://github.com/Microsoft/console/tree/master/tools/ColorTool
#>
Function Get-ColorScheme()
{
  [CmdletBinding()]
  Param(
    # Optional partial match for Itermcolors files in the `colortool` schemes
    # directory for argument completion.
    # Used as ArgumentCompleter for Set-ColorScheme -Scheme
    $Scheme
  )

  Begin {
    $colortool = Get-Command -Name "colortool"
  }
  Process {
    $colorschemes = $colortool.Path |
      ForEach-Object -Process {(Get-Item $_).Directory} |
      ForEach-Object -Process {Get-ChildItem $_ -Name "schemes/*.itermcolors"}
    return ($colorschemes |
      Where-Object {$_ -like "*$Scheme*"} | ForEach-Object {"$_"}
    )
  }
}
