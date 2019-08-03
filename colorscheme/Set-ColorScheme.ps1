Function Get-ColorScheme()
{
  [CmdletBinding()]
  Param()

  Begin {
    $colortool = Get-Command -Name "colortool"
  }
  Process {
    $colortool.Path |
      ForEach-Object -Process {(Get-Item $_).Directory} |
      ForEach-Object -Process {Get-ChildItem $_ -Name "schemes/*.itermcolors"}
  }

}

Function Set-ColorScheme()
{

  [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
  Param(
    [Parameter(Mandatory=$false)]
    [ArgumentCompleter(
      {
        #https://vexx32.github.io/2018/11/29/Dynamic-ValidateSet/
        Param($Command, $Parameter, $WordToComplete, $CommandAst, $FakeBoundParams)

        Get-ColorScheme
      }
    )]
    [ValidateScript(
      {
              $_ -in (Get-ColorScheme)
      }
    )]
    [string] $Scheme
  )
  Begin {
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
