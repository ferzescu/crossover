# Introduction
This document is describing on how to setup a monitoring solution using Icinga. Icinga should monitor the Apache Web Server and the Mysql Database server and send logs to Amazon S3 dynamically using Bash Scripting.

# Functional Requirements
1.	Download, install and configure Icinga solution on the server
2.	Troubleshoot any system issues to ensure availability of services
3.	Install Apache web server and a Mysql Database on different Docker containers
4.	Ensure that all logs that are generated by the Apache Web Server and Mysql Database are collected dynamically through a Bash Script
5.	Ensure that all logs that are generated by the Apache Web Server and Mysql Database are collected dynamically through a Bash Script
6.	Ensure that all logs that are generated by the Apache Web Server and Mysql Database are collected dynamically through a Bash Script
7.	Write a Chef Recipe (Puppet Manifest or Ansible Playbook) to automate this process.

# Pre-requirements
1.	Following repositories for CentOS should be presented before you will run ansible playbook (in case you’re using another distributive provide similar):

|REPO_ID | REPO_NAME |
|--------|-----------|
|DOCKER-MAIN-REPO | 	Docker main Repository |
|EPEL/X86_64 |                                                   	Extra Packages for Enterprise Linux 7 - x86_64 |
|ICINGA-STABLE-RELEASE/7SERVER	   |                               ICINGA (stable release for epel)  |
|RHUI-REGION-CLIENT-CONFIG-SERVER-7/X86_64	            |          rhui-REGION-client-config-server-7/x86_64 |
|RHUI-REGION-RHEL-SERVER-RELEASES/7SERVER/X86_64	      |         Red Hat Enterprise Linux Server 7 (RPMs)  |
|!RHUI-REGION-RHEL-SERVER-RH-COMMON/7SERVER/X86_64	    |          Red Hat Enterprise Linux Server 7 RH Common (RPMs) |


2.	Ansible version => 2.3.1.0 installed 
3.	User “ec2-user” with sudo permissions added
4.	“ec2-user” should have SSH access without password to the all instances
5.	Valid s3 bucket with Access and Secret keys. 
6.	Edit bucket= value with proper S3 bucket name in  bkp_file_upload.py and log_file_upload.py files located in Scripts\Python path
7.	Edit Scripts\Shell\cron_job.sh with proper Access and Secret Keys
8.	Fill list of instances for this task in /etc/ansible/hosts file
