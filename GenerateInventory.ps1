#
# Generate Ansible Inventory file for Hyper-V VMs
#

$InvFile = "ansible_hyperv.list"

$PrjDirPrefix = "Project"
$vmNamePrefix = $PrjDirPrefix + "*"

$vmInfo = Get-VM -Name $vmNamePrefix | Select-Object -ExpandProperty NetworkAdapters

Write-Host
Write-Host "Generating Inventory file..."
Write-Host

Write-Host "[hyperv]"
Set-Content -Path $InvFile -Value "[hyperv]"

$vmInfo | ForEach-Object {
	$vmName = $_.VMName
	$ipAddress = $_.IPAddresses[0]

	if ([string]::IsNullOrEmpty($ipAddress)) {
		Write-Host $vmName
		Add-Content -Path $InvFile -Value $vmName
	} else {
		Write-Host (($vmName, " ", "ansible_host=", $ipAddress) -join "")
		Add-Content -Path $InvFile -Value "$vmName ansible_host=$ipAddress"
	}
}

Add-Content -Path $InvFile -Value ""
Add-Content -Path $InvFile -Value "[all:vars]"
Add-Content -Path $InvFile -Value "ansible_connection=ssh"
Add-Content -Path $InvFile -Value "ansible_user=vagrant"
Add-Content -Path $InvFile -Value "ansible_ssh_pass=London01"
Add-Content -Path $InvFile -Value "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"

#
# Copy File to Ansible Control Server if Running.
#

$AnsibleVM = "Debian"
$vmState = Get-VM -Name $AnsibleVM | Select-Object -ExpandProperty State

if ($vmState -eq "Running") {
	Copy-VMFile -Name "Debian" -SourcePath $InvFile -DestinationPath "/home/patrol" -FileSource Host -Force
	Write-Host
	Write-Host "Inventory file $InvFile copied to /home/patrol on Host $AnsibleVM."
	Write-Host
}
