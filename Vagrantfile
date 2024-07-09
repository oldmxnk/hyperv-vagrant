# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|  
  number_of_machines = 3
  # box_name = "generic/debian9"
  box_name = "roboxes/centos7"

  # provisioning script - Add all required setup here
  script = <<-SCRIPT
    echo "====VM===="
    ip addr | grep \"inet\" | awk '{print $2}'
	sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
	systemctl restart sshd
	echo -e "London01\nLondon01" | (passwd vagrant)
    echo "====VM===="
  SCRIPT

  config.vm.box_check_update = false
  config.vm.boot_timeout = 90

  config.vm.provider "hyperv" do |h|
    h.cpus = 1
	h.memory = 256
	h.maxmemory = 512
	h.enable_virtualization_extensions = false
	h.enable_enhanced_session_mode = true
	h.enable_checkpoints = false
	h.vm_integration_services = {
		guest_service_interface: true,
		CustomVMSRV: true,
		heartbeat: true
	}
  end

  (1..number_of_machines).each do |i|
    config.vm.define "vm_#{i}", autostart:true do |box|
      box.vm.box = box_name
	  box.vm.hostname = "hyperv-vm#{i}"
      box.vm.provision "shell", inline: "#{script}"
    end
  end
end
