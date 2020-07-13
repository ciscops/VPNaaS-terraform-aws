# Deploying Remote Access VPN in AWS using Terraform

This project targets the automation for remote access VPN to allow the rapid spin-up of remote access VPN's in AWS using the virtual Cisco ASAv Firewall in AWS with Scalable Remote Access VPN with DNS-Loadbalancing utilizing AWS Route 53 Service option.  This is intended for those operators needing immediate spin-up of a scale-out remote access VPN service to quickly allow customers/employees a secure WFH or remote VPN service.  The examples in this REPO are leveraged from the excellent work done from the Cisco Netsec TME Design Team and their Blueprints collection REPO, which is a central location where Cisco will publish as part of the reference architecture designs for Public Cloud. [1](#References)

While this serves as a baseline setup for the components and automation of the AWS infrastructure, it is assumed any user of this setup applies their own company compliant ASAv firewall policies and remote security guidelines, as the ASAv setup in this repo targets basic connectitivity only.  It assumes Day 1+ ASAv firewall policies prior to final operation.

## Modifications to Public Cloud Next Generation Firewall Content

Leveraging the baseline work done in Terraform Blueprints for remote access VPN in AWS, this effort extended that effort to automate the entire setup using a Ansible playbook with Terraform modules.  In the original REPO, the base code breaks up the remote access VPN setup and configuration into multiple steps, from AWS key definition, to AWS VPC and ASA setup, to the final ASAv configuration and deployment.  The modifications here automates all of the necessary steps using a master Ansible playbook, for both applying the setup as well as destroying the setup, through the use of the Terraform module in Ansible.

### Requirements

The minimal requirements for this project can be found in the documentation highlighted below [1], but from a high level of what is needed

* An AWS account and credentials
* Terraform Installed
* Ansible
* (Optional): Terraform version manager (I found this useful in my testing to troubleshoot various versions with different elements of the Terraform testing and steps required)

#### Getting Started

This demonstration is leveraging the following version of code:

```
Terraform = 0.12.15
Ansible = version 2.9.5
tfenv = 2.0.0
```

While these versions will continue to change and evolve, for the end to end playbook to execute properly, I leveraged Terraform v0.12.15.  There are later versions available but this version was my lowest common I was able to leverage for consistency in executing the atomic playbook.

#### Cisco TME Reference

I would like to thank the Cisco Netsec TME Design Team for their excellent work on the remote access VPN efforts at the [Terraform Blueprints Repository](https://github.com/netsec-design/TerraformBluePrints), and thanks for their inspiration to to me to test this effort and evolve it.

#### References

[1]: Reference REPO that is collecting all the Blueprints which Cisco will release as part of the reference architecture designs for Public Cloud: https://github.com/netsec-design/TerraformBluePrints







