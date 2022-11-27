Function Import-Users
    {
    Param (
        [string] $OUName
        )

    $ExportName = "C:\DataFiles\"+$OUName+".csv"
    $Location = "OU="+$OUName+",DC=test-solar,DC=local"

    New-ADOrganizationalUnit -Name $OUName -Path "DC=test-solar,DC=clocal" -ProtectedFromAccidentalDeletion $False

    $LCPassword = "Action1!" | ConvertTo-SecureString -AsPlainText -Force

    Import-CSV $ExportName    |
    New-ADUser -Path $Location -AccountPassword $LCPassword -Enabled $TRUE

    }

Import-Users -OUName SupportStaff
Import-sers -OUName Managers
Import-Users -OUName Marketing
Import-Users -OUName ServiceStaff
