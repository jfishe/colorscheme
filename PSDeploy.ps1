
<#PSScriptInfo

.VERSION 1.0

.GUID f38c6831-18f6-4bbb-9eb7-157eb0c72615

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
 PSDeploy Script for colorscheme 

#> 
Param()


Deploy colorscheme {
    By PlatyPS {
        FromSource 'docs'
        To "colorscheme\en-US"
        Tagged Help, Module
        WithOptions @{
            Force = $true
        }
    }

    By PSGalleryModule {
        FromSource '.\colorscheme'
        To 'LocalRepo1'
        Tagged Prod
    }
}
