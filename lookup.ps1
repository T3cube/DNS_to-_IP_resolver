#get input for text file
try{
	$names = Get-Content $Args[0]
}
catch{
	Write-Host "include the text file as an argument. Usage: lookup [file_path]"
	exit 1
}
$foundsystems = ''

foreach ($name in $names){
#here we check the connection, if it fails we dont bother with the rest
    if (Test-Connection -ComputerName $name -Count 1 -ErrorAction SilentlyContinue){

        #get ipaddress by hostname
        try{
            $ips = [System.Net.Dns]::GetHostByName($name)
            $ips = $ips.AddressList[0].IPAddressToString
            Write-Output "$name host resolved to $ips" | Write-Host -ForegroundColor DarkGray
        }
        catch{
            Write-Output "Could not get name from address" | Write-host -ForegroundColor Red
        }

        try{
            #use the resolved ipaddress and get a hostname
            $namelookup = [System.Net.Dns]::GetHostByAddress($ips).Hostname
            Write-Output "$namelookup address resolved from $ips" | Write-Host -ForegroundColor White
        }
        catch{
            Write-Output "Did not get a hostname" | Write-host -ForegroundColor Red
        }

        #check if they match, not case sensitive
        if($namelookup -match $name){
            Write-Output "Match found for $name !!" | Write-Host -ForegroundColor Green

            #yes i know this is a hacky way to do a new line.....but the grave key that is supposed to handle it didnt work no matter what i tried
            $foundsystems += "$name
"
        }
    }
    else{
        Write-Output "$name cannot be reached" | Write-Host -ForegroundColor Yellow
    }
}
Write-Output "	▽	▽	▽	▽	▽	▽	▽	▽"
Write-Output "Listing connected systems"
foreach($system in $foundsystems){
    Write-Output "$system" | Write-Host -ForegroundColor Green
}
Read-Host "Done. Press enter to return"