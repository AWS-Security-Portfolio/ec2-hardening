## AWS EC2 Hardening Lab

Hardened EC2 deployment using least privilege IAM roles, restricted security groups, SSM-based management, and OS-level controls for secure, auditable AWS compute.

---

## Table of Contents

- [Overview]
- [Real-World Risk]
- [What I Built]
- [Diagram]
- [Objectives]
- [Steps Performed]
  - [1. IAM Role Creation]
  - [2. Security Group Setup]
  - [3. EC2 Instance Launch]
  - [4. Secure Instance Management with SSM]
  - [5. SSH Hardening]
  - [6. OS Updates and Auditing]
  - [7. Cleanup]
- [Screenshots]
- [Lessons Learned]
- [References]

---

## Overview

This project demonstrates the process of securely deploying and hardening an Amazon EC2 instance in AWS, following CIS benchmarks and AWS best practices. The lab focuses on minimizing attack surface, enforcing least privilege, automating instance management, and implementing essential security controls.

---

## Real-World Risk

In real-world cloud environments, improperly secured EC2 instances are a common entry point for attackers. Exposed SSH ports, weak IAM permissions, outdated operating systems and a lack of auditing can enable unauthorized access, privilege escalation, data exfiltration or even full infrastructure compromise. Without proper hardening and monitoring, a single misconfiguration can lead to ransomware, cryptomining or breaches with significant business and reputational impact. This lab addresses these risks by enforcing strong access controls and system security at every layer.

---

## What I Built

- Launched an Amazon EC2 instance with Amazon Linux 2.
- Applied a Security Group that only allows required traffic (SSH from my IP, HTTP/HTTPS from the internet)
- Created and attached an IAM role with the least-privilege permissions needed for SSM management.
- Enforced AWS Systems Manager Session Manager for secure, keyless remote access (no public SSH)
- Hardened the OS by disabling root login and password authentication in SSH configuration.
- Applied all available OS updates and patches.
- Installed, enabled, and verified auditd for system activity logging.
- Documented the process with before/after evidence and automation scripts.

---

## Diagram

![Architecture Diagram](diagram.png)

---

## Objectives

- Launch an EC2 instance using secure defaults.
- Apply a Security Group allowing only necessary traffic (SSH, HTTP, HTTPS)
- Attach an IAM role with minimum permissions required for SSM management.
- Enforce use of AWS Systems Manager Session Manager instead of public SSH access.
- Harden the operating system by disabling root login, password authentication, and ensuring system patching.
- Enable system auditing with `auditd`.

---

## Steps Performed

**1. IAM Role Creation**
   - Created a dedicated IAM role with the AmazonSSMManagedInstanceCore policy for secure SSM access *(Screenshot: iam-role-policy-attach.png)*

**2. Security Group Setup**
   - Configured a Security Group to only allow required inbound traffic:
      - SSH (port 22) from my IP address.
      - HTTP (80) and HTTPS (443) from the internet *(Screenshot: sg-inbound-rules.png)*

**3. EC2 Instance Launch**
   - Launched an EC2 instance with Amazon Linux 2, attaching the custom IAM role and Security Group.
   - Configured advanced settings to enforce IMDSv2 and verify launch parameters *(Screenshots: ec2-advanced-details.png, ec2-advanced-details-2.png & ec2-launch-summary.png)*

**4. Secure Instance Management with SSM**
   - Verified the instance registered as "Managed" in SSM Fleet Manager *(Screenshot: ssm-fleet-managed.png)*
   - Connected to the instance using Session Manager, proving secure, keyless administration *(Screenshot: ssm-session.png)*

**5. SSH Hardening**
   - Captured the initial SSH configuration state before hardening *(Screenshot: sshd-before.png)*
   - Disabled root login and password authentication in /etc/ssh/sshd_config.
   - Reloaded SSH service and verified the hardened settings *(Screenshot: sshd-after.png)*

**6. OS Updates and Auditing**
   - Applied all available system updates and patches using the OS package manager *(Screenshot: os-update.png)*
   - Installed, enabled, and verified the auditd service for system activity logging *(Screenshot: auditd-status.png)*

**7. Cleanup**
   - Terminated the EC2 instance, deleted the custom Security Group and IAM role to avoid ongoing costs.

---

## Screenshots

*All relevant screenshots demonstrating each step are included in the screenshots/ folder of this repository.

| Order | File Name                  | What it Shows                                 |
| ----- | -------------------------- | --------------------------------------------- |
| 1     | iam-role-policy-attach.png | IAM role policy attached for SSM              |
| 2     | sg-inbound-rules.png       | Security Group inbound firewall rules         |
| 3     | ec2-advanced-details.png   | IAM role in EC2 advanced details              |
| 4     | ec2-advanced-details-2.png | Metadata v2 in EC2 advanced details           |
| 5     | ec2-launch-summary.png     | EC2 launch summary (shows all config)         |
| 6     | ssm-session.png            | SSM Session Manager access (browser terminal) |
| 7     | ssm-fleet-managed.png      | SSM Fleet Manager—instance is “Managed”       |
| 8     | sshd-before.png            | SSH config before hardening                   |
| 9     | sshd-after.png             | SSH config after hardening                    |
| 10    | os-update.png              | OS/system update completion                   |
| 11    | auditd-status.png          | auditd running and enabled                    |

---

## Lessons Learned

- Restricting network and IAM permissions is essential for minimizing attack surface.
- SSM Session Manager provides a more secure alternative to SSH for administrative access.
- Hardening SSH settings and keeping systems updated significantly improves security posture.
- Enabling auditing (auditd) helps detect and investigate unauthorized or suspicious activity.

---

## References

- CIS Amazon Linux 2 Benchmark
  (https://www.cisecurity.org/benchmark/amazon_linux/)

- AWS EC2 Security Best Practices
  (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-best-practices.html)

- AWS Systems Manager Documentation
  (https://docs.aws.amazon.com/systems-manager/)

---

Sebastian Silva C. - July, 2025 - Berlin, Germany.
