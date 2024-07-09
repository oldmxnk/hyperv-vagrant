#
# Generate Ansible Inventory file for Hyper-V VMs
#
$vmInfo  = Get-VM | Select-Object -ExpandProperty NetworkAdapters
Write-Host
Write-Host "Generating Inventory file..."
Write-Host

Write-Host "[hyperv]"
Set-Content -Path "ansible_hyperv.list" -Value "[hyperv]"

$vmInfo | ForEach-Object {
	$vmName = $_.VMName
	$ipAddress = $_.IPAddresses[0]

	if ([string]::IsNullOrEmpty($ipAddress)) {
		Write-Host $vmName
		Add-Content -Path "ansible_hyperv.list" -Value $vmName
	} else {
		Write-Host (($vmName, " ", "ansible_host=", $ipAddress) -join "")
		Add-Content -Path "ansible_hyperv.list" -Value "$vmName ansible_host=$ipAddress"
	}
}

Add-Content -Path "ansible_hyperv.list" -Value ""
Add-Content -Path "ansible_hyperv.list" -Value "[all:vars]"
Add-Content -Path "ansible_hyperv.list" -Value "ansible_connection=ssh"
Add-Content -Path "ansible_hyperv.list" -Value "ansible_user=vagrant"
Add-Content -Path "ansible_hyperv.list" -Value "ansible_ssh_pass=London01"
Add-Content -Path "ansible_hyperv.list" -Value "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"

#
# Copy File to Ansible Control Server if Running.
#
$vmName  = "Debian"
$vmState = Get-VM -Name $vmName | Select-Object -ExpandProperty State

if ($vmState -eq "Running") {
	Copy-VMFile -Name "Debian" -SourcePath "ansible_hyperv.list" -DestinationPath "/home/patrol" -FileSource Host -Force
	Write-Host
	Write-Host "Inventory file copied to /home/patrol on Host $vmName."
	Write-Host
}
