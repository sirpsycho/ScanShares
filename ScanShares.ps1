
###
### Scan a list of servers for available network shares
###



# define an input file - containing a list of the servers to scan
$serversFile = "servers.txt"

# define an output file
$OutFile = "ServerShares.csv"



# Make sure input file exists and is not empty
if (-Not (Test-Path $serversFile -PathType Leaf)) {
	write-host "[!] Could not find input file '$serversFile'"
	exit
}
$servers = Get-Content -Path $serversFile
if (-Not ($servers)) {
	write-host "[!] No servers to scan"
	exit
}

# initialize Server Shares hash table
$ServerShares = @{}

# Start scan
write-host "Scanning" $servers.length "servers..."
foreach ($server in $servers) {

	# Initialize hash key
	$ServerShares.Add($server, @())

	# get a list of shares for the given server
	$shares = net view \\$server /all 2> $null | select -Skip 7 | ?{$_ -match 'disk*'} | %{$_ -match '^(.+?)\s+Disk*'|out-null;$matches[1]}

	# if there are shares, loop through them
	if ($shares) {
		foreach ($share in $shares) {
			$ServerShares.$server += $share
		}
		write-host "[+] found" $ServerShares.$Server.length "shares on '$server'"
	} else { write-host "[-] found 0 shares on '$server'" }
}

# Export shares to CSV
write-host "`n[-] Exporting results to '$OutFile'..."

# if the file exists already, delete the old one
if (Test-Path $OutFile -PathType Leaf) {
	Clear-Content $OutFile
}

# Add column headers
Add-Content -Force $OutFile "Server,Share"

# loop through each hash key, sorting by server name
foreach ($server in ($ServerShares.Keys | Sort-Object)) {

	# append each share for each server
	foreach ($share in $ServerShares.$server) {
		Add-Content -Force $OutFile "$server,$share"
	}
}
write-host "[+] Done"





