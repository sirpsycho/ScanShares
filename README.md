
# ScanShares 

A simple Powershell script that can be used to find accessible shares on a network.


# Use Cases

It's important to note that this script relies on the permissions of the user initiating the script. The shares that are listed will therefore only be the shares that this user is able to see. For this reason, this is probably less of a strictly offensive / red team scanning tool and really more of a blue team / audit tool, although it could technically be used for either. A systems administrator could use this to find rouge fileservers, servers that require extra security, or excessive share permissions. A red team member could hypothetically use this to enumerate share access in the context of a newly compromised user account.


# Tool Usage

By default, the script will look for a text file named "servers.txt" to be used as input, and output a CSV file named "ServerShares.csv" that will contain the detailed script results. This can of course be modified to print all output to the console window, or use different file names, or whatever you want. This is really just some proof-of-concept code. To run as-is, simply create a file (in the same directory as this script) named "servers.txt" with one server name per-line, then open a powershell window and run '.\ScanShares.ps1'. See the sample output below:


```
> .\ScanShares.ps1
Scanning 4 servers...
[+] found 12 shares on 'fileserver1'
[+] found 0 shares on 'fileserver2'
[+] found 103 shares on 'fileserver3'
[+] found 4 shares on 'fileserver4'

[-] Exporting results to 'ServerShares.csv'...
[+] Done
```
