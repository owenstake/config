# copy file from clipboard to DesDir for win10 explorer

Param([Parameter(Mandatory = $True, Position = 1)][string] $DesDirPath)
Add-Type -AssemblyName System.Windows.Forms
$fileDropList = new-object System.Collections.Specialized.StringCollection;

if (-not [System.Windows.Forms.Clipboard]::ContainsFileDropList()) {
    Write-Verbose "No appendable content was found."
} else {
    $fileDropList = [System.Windows.Forms.Clipboard]::GetFileDropList()
}

foreach ($file in $fileDropList) {
    Copy-Item -Path $file -Destination (Get-Item -Path $DesDirPath).FullName -Recurse
}

# foreach ($bird in $birds)
# {
#   $count += 1
#   "$bird = " + $bird.length
# Write-Host
# }
# "Total number of birds is $count."