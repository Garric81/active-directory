Function Import-Users
    {
    Param (
        [string] $OUName
        )

    $ExportName = "C:\DataFiles\"+$OUName+".csv"
    $Location = "OU="+$OUName+",DC=test-solar,DC=local"

    New-ADOrganizationalUnit -Name $OUName -Path "DC=test-solar,DC=local" -ProtectedFromAccidentalDeletion $False

    $LCPassword = "Action1!" | ConvertTo-SecureString -AsPlainText -Force

    Import-CSV $ExportName    |
    New-ADUser -Path $Location -AccountPassword $LCPassword -Enabled $TRUE

    }

$CheckFolder = Test-Path C:\DataFiles\*.csv
If ( $CheckFolder -eq $True )
    {

    Set-Location C:\DataFiles
    Set-Content .\Files.txt (Get-ChildItem).Name

    (Get-Content .\Files.txt ).Replace('.csv','') | Out-File .\Process.txt
   
    ForEach ($OrgUnit in Get-Content C:\DataFiles\Process.txt)
        {
        Import-Users -OUName $OrgUnit
        }

    }
    Else { Write-Host "Create a directory named DataFiles in the root of C and place in it the CSV exports. The attempt this script again" }