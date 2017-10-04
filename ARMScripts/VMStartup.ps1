<#
    .SYNOPSIS
        VM Start-up configuration.
#>

Param (

)

#Create folders
New-Item -ItemType Directory c:\Azure-Lab-20171018\Install

#Uninstall the old version of the Data Management Gateway
$app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match "Microsoft Data Management Gateway"}
$app.Uninstall()

#Download the new version of Data Management Gateway
Invoke-WebRequest "https://download.microsoft.com/download/E/4/7/E4771905-1079-445B-8BF9-8A1A075D8A10/IntegrationRuntime_3.0.6464.2 (64-bit).msi" -OutFile "c:\Azure-Lab-20171018\Install\dmg.msi"

#Install the new version of Data Management Gateway
Start-Process "c:\Azure-Lab-20171018\Install\dmg.msi" -ArgumentList '/quiet' -Wait

# Download and extract the course files
Invoke-WebRequest  "https://github.com/sgiovinetti/ChampLab20171018/raw/master/LabFiles.zip" -OutFile "c:\Azure-Lab-20171018\Install\LabFiles.zip"
#Requires PWS 5.0 --- Expand-Archive "c:\Azure-Lab-20171018\Install\LabFiles.zip" "c:\tmp"

Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory("c:\Azure-Lab-20171018\Install\LabFiles.zip", "c:\tmp")

# Set Desktop path
$DesktopPath = "C:\Users\Public\Desktop"

#Copy TinyUrls to desktop
Copy-Item "c:\tmp\ShortCuts\TinyUrls.txt" $DesktopPath

#Copy IE Portal Shortcut to Desktop
Copy-Item "c:\tmp\ShortCuts\Azure Portal.URL" $DesktopPath