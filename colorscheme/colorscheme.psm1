Get-ChildItem *.ps1 -Path $PSScriptRoot\export |
  ForEach-Object -Process {
    . $_.FullName
  }

Get-ChildItem *.ps1 -Path $PSScriptRoot\export |
  ForEach-Object -Process {
    Export-ModuleMember $_.BaseName
  }
