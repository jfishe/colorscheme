---
external help file: colorscheme-help.xml
Module Name: colorscheme
online version: https://github.com/jfishe/colorscheme/blob/master/docs/Set-ColorScheme.md
schema: 2.0.0
---

# Set-ColorScheme

## SYNOPSIS

Set console color scheme using Microsoft ColorTool

## SYNTAX

### Apply (Default)

```
Set-ColorScheme [-Quiet] [-Both] [-SchemeName] <String> [-Path <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Xterm

```
Set-ColorScheme [-Quiet] [-Xterm] [-SchemeName] <String> [-Path <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Defaults

```
Set-ColorScheme [-Defaults] [-SchemeName] <String> [-Path <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Version

```
Set-ColorScheme [-Version] [-Path <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Change the current and/or default console color scheme using ColorTool.

Specify a colorscheme in INI or itermcolors format.
The module assumes the color scheme is in the schemes/ directory installed with ColorTool, unless a path to the scheme is specified.

## PARAMETERS

### -Quiet

Suppress output of color scheme table.

```yaml
Type: SwitchParameter
Parameter Sets: Apply, Xterm
? Aliases

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Both

Change current and default console color scheme.

This does NOT save the properties automatically.
For that, you'll need to open the properties sheet and hit "Ok".

```yaml
Type: SwitchParameter
Parameter Sets: Apply
? Aliases

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Defaults

Change default console color scheme.

This does NOT save the properties automatically for the current console.
For that, you'll need to open the properties sheet, select Defaults and hit "Ok".

```yaml
Type: SwitchParameter
Parameter Sets: Defaults
? Aliases

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Xterm

Change current color scheme and output ANSI escape sequences for use in WSL console.

```yaml
Type: SwitchParameter
Parameter Sets: Xterm
? Aliases

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
Parameter Sets: Version
? Aliases

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SchemeName

Change current console color scheme.

This does NOT save the properties automatically.
For that, you'll need to open the properties sheet and hit "Ok".

```yaml
Type: String
Parameter Sets: Apply, Xterm, Defaults
? Aliases

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specify path to ColorTool

```yaml
Type: String
Parameter Sets: (All)
? Aliases

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
For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

Microsoft provides pre-built ColorTool binaries or you can build from source.
See RELATED LINKS.
Install any additional schemes in the schemes/ folder included with ColorTool.

The module assumes that ColorTool and schemes/ are installed in the same directory as $PROFILE or in $env:PATH.

## RELATED LINKS

[https://github.com/jfishe/colorscheme/blob/master/docs/Set-ColorScheme.md](https://github.com/jfishe/colorscheme/blob/master/docs/Set-ColorScheme.md)

[https://github.com/Microsoft/console/tree/master/tools/ColorTool](https://github.com/Microsoft/console/tree/master/tools/ColorTool)
