#!/bin/bash

# Each debian-based machine IP is added on a new line in quotes
TARGETS=("192.168.0.1"
"192.168.0.2"
"192.168.0.3")

# Set manager IP first
WAZUH_MANAGER="192.168.255.255"
function debWazuhInstall {
	for TARGET in "${TARGETS[@]}"; do
		printf '%s\n' "${SECRET}" | ssh -q "${TARGET}" 'echo;
			sudo -S WAZUH_MANAGER="'"${WAZUH_MANAGER}"'" WAZUH_REGISTRATION_SERVER="'"${WAZUH_MANAGER}"'" apt install ~/wazuh-client.deb;
      sudo -S sed -i s/MANAGER_IP/55.5.1.241/ /var/ossec/etc/ossec.conf;
      sudo -S systemctl start wazuh-agent.service;
		echo'
  done
}


# Set the static values before running
VELOCIRAPTOR_BIN_NAME="velociraptor-0.6.0-1-amd64"
VELOCIRAPTOR_BIN_LOC="/usr/bin/"
VELOCIRAPTOR_CONFIG_NAME="client.config.yaml"
VELOCIRAPTOR_CONFIG_LOC="/etc/velociraptor/"
VELOCIRAPTOR_SERVICE_NAME="velociraptor.service"
VELOCIRAPTOR_SERVICE_LOC="/lib/systemd/system/"
function debVelociraptorInstall {
	for TARGET in "${TARGETS[@]}"; do
		printf '%s\n' "${SECRET}" | ssh -q "${TARGET}" 'echo;
      sudo -S mkdir '"${VELOCIRAPTOR_CONFIG_LOC}"';
      sudo -S mv ~/'"${VELOCIRAPTOR_BIN_NAME} ${VELOCIRAPTOR_BIN_LOC}"'/.;
      sudo -S mv ~/'"${VELOCIRAPTOR_CONFIG_NAME} ${VELOCIRAPTOR_CONFIG_LOC}"'/.;
      sudo -S mv ~/'"${VELOCIRAPTOR_SERVICE_NAME} ${VELOCIRAPTOR_SERVICE_LOC}"'/.;
      sudo -S chmod 0755 '"${VELOCIRAPTOR_BIN_LOC}/${VELOCIRAPTOR_BIN_NAME}"';
      sudo -S chown root:root '"${VELOCIRAPTOR_BIN_LOC}/${VELOCIRAPTOR_BIN_NAME}"';
      sudo -S chown root:root '"${VELOCIRAPTOR_CONFIG_LOC}/${VELOCIRAPTOR_CONFIG_NAME}"';
      sudo -S chown root:root '"${VELOCIRAPTOR_SERVICE_LOC}/${VELOCIRAPTOR_SERVICE_NAME}"';
      sudo -S systemctl daemon-reload;
      sudo -S systemctl restart velociraptor.service;
		echo'
  done
}

IFS= read -rsp 'Enter: ' SECRET; echo;
debWazuhInstall
debVelociraptorInstall
