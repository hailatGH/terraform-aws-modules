#cloud-config
package_update: true
package_upgrade: true
package_reboot_if_required: false

timezone: ${timezone}
ntp:
  enabled: true

users:
  - name: ${username}
    groups: sudo
    sudo: "ALL=(ALL) NOPASSWD:ALL"
    lock_passwd: true
    shell: /bin/bash
    ssh_authorized_keys:
%{ for key in ssh_keys ~}
      - ${key}
%{ endfor ~}

ssh_pwauth: false

final_message: "The system is finally up, after $UPTIME seconds"