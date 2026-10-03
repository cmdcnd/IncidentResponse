# 7. Tactical Server Hardening

Use this guide for targeted containment and hardening of Linux file-transfer servers, Windows Servers, and Linux hosts during an active incident. It complements the preparation, identification, containment, eradication, recovery, and lessons-learned procedures in this repository; it does not replace the incident lead's response plan, the mission partner's change process, or platform-specific security baselines.

Recommendations are starting points, not universal settings. Confirm platform versions, business and operational dependencies, access paths, and mission-partner authorization before changing production systems. Preserve evidence and record approvals, changes, timestamps, and verification results.

## Operating Principles

* **Evidence first:** Coordinate with forensic personnel and capture volatile data and forensic images as appropriate before changes. Do not clear event or authentication logs, delete shell history, overwrite temporary or log directories, or remove suspected payloads before evidence is preserved.
* **Contain before eradicating:** Prioritize approved network isolation, ingress and egress restrictions, and lateral-movement controls before broad credential resets, rebuilds, or cleanup.
* **Sequence the work:** Use Phase 1 for rapid containment (0–24 hours), Phase 2 for tactical hardening and eradication (24–72 hours), and Phase 3 for post-eviction baselines and monitoring (72+ hours). Adjust timing to incident conditions.
* **Protect access and availability:** Stage changes, retain an out-of-band or alternate administrative path, test from a separate session, and prepare a rollback. Do not apply a firewall or authentication change that could strand responders.
* **Verify and monitor:** Validate effective configuration and service health after each change, then monitor for renewed access, persistence, or command-and-control activity.

## 1. Linux FTP and File-Transfer Servers

FTP deployments differ by daemon and distribution. Identify the daemon, configuration path, service name, TLS capabilities, and clients before editing. Where operationally feasible, replace FTP with OpenSSH SFTP through a managed jump host.

### Phase 1: Rapid Containment

* Disable anonymous access using the setting supported by the installed daemon:
  * vsftpd: set `anonymous_enable=NO` in the active `vsftpd.conf` (commonly `/etc/vsftpd/vsftpd.conf` or `/etc/vsftpd.conf`).
  * ProFTPD: disable the applicable `<Anonymous>` block in the active configuration.
  * Pure-FTPd: use its no-anonymous option (commonly `-E`) or the distribution's supported `NoAnonymous yes` setting.
* Where TLS is supported, require encrypted sessions (FTPS) and disable obsolete TLS versions. For a compatible vsftpd configuration, for example:

  ```ini
  ssl_enable=YES
  allow_anon_ssl=NO
  force_local_logins_ssl=YES
  force_local_data_ssl=YES
  ssl_tlsv1=NO
  ssl_tlsv1_1=NO
  ssl_tlsv1_2=YES
  ```

  Confirm the daemon supports these directives and negotiate a maintenance window if clients may break. Do not treat FTPS control-channel encryption alone as proof that data transfers are encrypted.
* Restrict TCP 21 and the configured passive data-port range to authorized source networks at the host firewall and applicable cloud security controls. A narrow range such as TCP 40000–40100 is an example only; configure the same range on the daemon and firewall.
* For NAT or cloud-hosted servers, set the daemon's advertised passive address to the intended public or reachable address. Do not enable options that relax peer-address checks (such as vsftpd `pasv_promiscuous`) as a NAT workaround.
* Before changing firewall or security-group rules, verify the responder's management path and required client subnets. FTP passive-mode mismatches can interrupt transfers; restrictive SSH rules can sever administration.

### Phase 2: Tactical Hardening and Eradication

* For vsftpd, confine local users with `chroot_local_user=YES`. Keep the chroot root non-writable where possible; provide write access only to a dedicated upload subdirectory. Do not enable writable chroot as a quick workaround without assessing the daemon version and risk.
* Use a supported allowlist for FTP users. For vsftpd, `userlist_enable=YES`, `userlist_file=...`, and `userlist_deny=NO` allow only listed users; confirm the active list and keep an administrator access path before reloading.
* Assign FTP-only accounts a non-login shell such as the distribution's `nologin` path, and ensure they cannot use SSH or other services. Verify account dependencies before changing shells.
* Enable the daemon's transfer and protocol logging where supported. Forward relevant logs to a remote collector and confirm receipt. Preserve local logs during the incident.
* Review upload and home directories for unexpected, hidden, or executable files. Preserve and hash suspected artifacts before containment or quarantine. Avoid broad recursive permission changes such as `chmod -R a-x`, which can break legitimate services and destroy useful metadata.

### Phase 3: Post-Eviction Baseline

* Remove unused FTP services or migrate to managed SFTP. Apply the current vendor-supported baseline and patches.
* Revalidate anonymous access, user allowlists, chroot boundaries, TLS negotiation, passive-port restrictions, and remote log delivery. Monitor uploads and authentication activity.

## 2. Windows Server

### Phase 1: Rapid Containment

* Restrict inbound SMB (TCP 445) and RPC endpoint mapper (TCP 135) from general workstation networks. Permit only required, documented flows and approved management jump hosts. Validate domain, backup, clustering, and application dependencies before blocking.
* Scope firewall and cloud network rules to known administrative subnets. Maintain a tested alternate management route before applying restrictions.
* Identify potentially compromised privileged accounts and coordinate targeted containment with the incident lead. Avoid broad resets until containment sequencing and service-account dependencies are understood.

### Phase 2: Tactical Hardening and Eradication

* Disable LLMNR through the applicable Group Policy setting: **Computer Configuration > Administrative Templates > Network > DNS Client > Turn off multicast name resolution**. Validate policy application and monitor for name-resolution dependencies.
* Disable NetBIOS over TCP/IP through DHCP or an approved adapter-management policy. Inventory adapters and test legacy dependencies before rollout.
* Disable SMBv1 on both server and client roles where present. For SMB server configuration, an example is:

  ```powershell
  Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
  ```

* Require SMB signing in accordance with the server role and compatibility requirements. For example, `Set-SmbServerConfiguration -RequireSecuritySignature $true -Force` changes the server-side requirement; assess client-side policy separately.
* Enable SMB encryption for shares that require it and whose clients support it. For example, `Set-SmbShare -Name "<ShareName>" -EncryptData $true` applies encryption to a specific share. Confirm performance, client compatibility, and successful access.
* Enable LSASS protection using the supported Windows security baseline or policy. `RunAsPPL` prevents non-protected processes from injecting code or reading LSASS process memory. If setting `HKLM\SYSTEM\CurrentControlSet\Control\Lsa\RunAsPPL`, validate the Windows version and deployment method and plan for the required restart.
* Set `HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest\UseLogonCredential` to `0` (DWORD) to prevent WDigest from storing reusable credentials in memory, where applicable. Verify the effective setting and any application dependencies.
* Apply **Deny access to this computer from the network** to built-in local administrator accounts only after confirming the policy's scope and ensuring responders retain an authorized administrative account and recovery route.
* Use Windows Defender Firewall to scope SMB and RPC access to approved systems rather than indiscriminately blocking required server-to-server traffic.

### Phase 3: Post-Eviction Baseline

* Assess the Windows Server Security Baseline and applicable Azure Security Benchmark recommendations. Roll out approved settings through managed policy, test compatibility, and document exceptions.
* Evaluate applicable Defender Attack Surface Reduction rules in audit mode before enforcement. Review alerts, business impact, and exclusions before changing production policy.
* Recheck SMB protocol versions, signing and encryption requirements, firewall scope, local administrator access, and policy application. Monitor authentication and remote administration events.

## 3. General Linux Hosts

### Phase 1: Rapid Containment

* Restrict SSH ingress at host and cloud boundaries to approved bastion or responder addresses. Confirm a working alternate session and out-of-band recovery path before applying firewall changes.
* Preserve evidence before stopping services, deleting persistence, or changing accounts. Record running processes, network connections, logged-in users, and relevant system state using the approved forensic process.
* Apply targeted egress controls to known malicious destinations through approved network controls. Monitor for operational impact and alternate C2 paths.

### Phase 2: Tactical Hardening and Eradication

* Disable direct root SSH access and password authentication only after confirming key-based access, sudo access, and recovery access work. A common SSH configuration is:

  ```text
  PermitRootLogin no
  PasswordAuthentication no
  ```

  Validate the effective configuration with the distribution-supported sshd test command (commonly `sshd -t`) and reload, rather than restart, where supported. Keep the original administrative session open and test a new one before closing it.
* Consider mounting `/tmp`, `/var/tmp`, and `/dev/shm` with `noexec,nosuid,nodev` only after testing application, package-management, and service dependencies. `noexec` is a defense-in-depth control, not a complete execution barrier. Back up configuration and confirm rollback access before changing `/etc/fstab`.
* Review cron locations, user crontabs, systemd units and timers, and other startup mechanisms for unexpected entries. Preserve suspicious files and metadata before disabling or removing them.
* Review accounts with interactive shells and all relevant `authorized_keys` files. Validate ownership and provenance before removing access; capture suspicious keys and account data as evidence.
* Configure `auditd` rules appropriate to the distribution and architecture to monitor account and authentication changes, sensitive configuration (including `/etc/pam.d/`), and process execution where feasible. Forward audit logs remotely and verify event generation and delivery.

### Phase 3: Post-Eviction Baseline

* Apply the current vendor-supported RHEL or Ubuntu security baseline and relevant CIS Benchmark recommendations. Use staged assessment and documented exceptions rather than copying settings blindly.
* Confirm SSH access controls, mount options, account and key inventory, audit coverage, time synchronization, patch status, and remote log collection. Continue monitoring for persistence and re-compromise.

## Verification and Change Record

For each change, record the host and owner, incident phase, evidence-preservation status, approval, prior and new settings, commands or policies applied, validation results, service impact, rollback steps, and monitoring owner. Confirm the intended setting is effective, required business services still operate, and responder access remains available.

## References

* [NIST SP 800-61 Rev. 3: Incident Response Recommendations and Considerations](https://csrc.nist.gov/pubs/sp/800/61/r3/final)
* Microsoft DART (Detection and Incident Response Team): Compromise Recovery Guide and Ransomware Response Playbooks
* [Microsoft Security Compliance Toolkit](https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/windows-security-configuration-framework/security-compliance-toolkit-10)
* [Microsoft SMB security enhancements](https://learn.microsoft.com/en-us/windows-server/storage/file-server/smb-security)
* [Microsoft Defender Attack Surface Reduction rules](https://learn.microsoft.com/en-us/defender-endpoint/attack-surface-reduction-rules-reference)
* Mandiant Incident Response and Tactical Hardening Guidelines (eviction sequencing and credential containment)
* Palo Alto Networks Unit 42: Incident Response and Cloud Containment Playbooks (cloud perimeter lockdown and service account/token isolation)
* [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks)
* [Red Hat Enterprise Linux Security Hardening](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/)
* [Ubuntu Security documentation](https://ubuntu.com/security)
