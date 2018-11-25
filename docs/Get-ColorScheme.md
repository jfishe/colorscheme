---
external help file: colorscheme-help.xml
Module Name: colorscheme
online version: https://github.com/Microsoft/console/tree/master/tools/ColorTool
schema: 2.0.0
---

# Get-ColorScheme

## SYNOPSIS
Get current console color scheme using Microsoft ColorTool.

## SYNTAX

### help
```
Get-ColorScheme [-Help] [-Path <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### current
```
Get-ColorScheme [-Current] [-Path <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### schemes
```
Get-ColorScheme [-Schemes] [-Path <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### version
```
Get-ColorScheme [-Version] [-Path <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### output
```
Get-ColorScheme -Output <String> [-Path <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Display the current or available color schemes installed with ColorTool.

Output the current color scheme in ColorTool INI format.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Help
Display help

```yaml
Type: SwitchParameter
Parameter Sets: help
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Current
Display current color scheme

```yaml
Type: SwitchParameter
Parameter Sets: current
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Schemes
Display available color schemes

```yaml
Type: SwitchParameter
Parameter Sets: schemes
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Version
Display version

```yaml
Type: SwitchParameter
Parameter Sets: version
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Output
Save current color scheme

```yaml
Type: String
Parameter Sets: output
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Specify path to ColorTool

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: (Get-Item $PROFILE).Directory.FullName
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Microsoft provides pre-built ColorTool binaries or you can build from source.
See RELATED LINKS.
Install any additional schemes in the schemes/ folder
included with ColorTool.

The module assumes that ColorTool and schemes/ are installed in the same
directory as $PROFILE or in $env:PATH.

## RELATED LINKS

[https://github.com/Microsoft/console/tree/master/tools/ColorTool](https://github.com/Microsoft/console/tree/master/tools/ColorTool)

