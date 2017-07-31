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

# Installation
Before you begin check Ansible readiness by executing:
_ansible -m ping all_

Output should be something like:
_localhost | success >> { "changed": false, "ping": "pong" }_

If everything is OK, we can continue with playbook execution:
_sudo ansible-playbook configure_playbook.yml_

This playbook will implement following tasks:
  - Add user “itriputen” with sudo permission to all hosts
  - Allow SSH connections with password
  - Cloning GIT repo
  - Install Icinga with configuration file
  - Install Docker-engine service
  - Install python libs dependences
  - Pull Apache and MySQL images for Docker
  - Run Docker containers
  - Run Icinga daemon
  - Copy cron script to root home dir
  - Create cron job to send files to S3

After installation process complete without any errors, you can verify it by checking running containers:
_docker ps_

Output should contains 2 running containers:
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
56d1d1ee5fe3        httpd               "/bin/sh -c '/usr/..."   8 hours ago         Up 8 hours          0.0.0.0:80->80/tcp       myhttpd
0416ab8c6e4e        mysql               "/sbin/my_init"          8 hours ago         Up 8 hours         0.0.0.0:3306->3306/tcp   mydb

For finish installation process, you need manually configure DB for Icinga usage by executing following:
 _docker exec -i -t mydb /bin/bash
 cd /etc/mysql
 mysql -proot -uroot < icinga.sql
 mysql -Dicinga -proot -uroot < icinga_schema.sql
 _exit (exiting DB)
 exit (exiting container)
 sudo systemlctl restart icinga (restarting to make Icinga service take effect)_

To test the Icinga run following command:
_icinga --show-scheduling /etc/icinga/icinga.cfg_
