
install ansible

sudo apt-get update 

apt install vim
dhclient -r ens33
dhclient 

shutdown -h now
reboot 
#for cdrom issue remove the cdrom from the /ect/apt/sources.list (https://askubuntu.com/questions/776721/problem-with-sudo-apt-get-update-the-repository-cdrom-does-not-have-a-releas)
#install latest vim
apt-get install vim
apt install openssh-server
systemctl status ssh

sudo apt-get install software-properties-common 

sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update 
sudo apt-get install ansible

sudo add-apt-repository --remove ppa:ansible/ansible


ANSIBLE_CFG: This is an environment variable
~/ansible.cfg: This is in the current directory
ansible.cfg: This is in the user's home directory
./etc/ansible/ansible.cfg

sudo snap install powershell --classic powershell

lsb_release -a

sudo apt-get install libunwind8 libicu55

wget http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu55_55.1-7ubuntu0.4_amd64.deb
sudo apt install ./libicu55_55.1-7ubuntu0.4_amd64.deb

# Download the Microsoft repository GPG keys
wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb

# Register the Microsoft repository GPG keys
sudo dpkg -i packages-microsoft-prod.deb

# Update the list of products
sudo apt-get update

# Install PowerShell
sudo apt-get install -y powershell

# Start PowerShell
pwsh

Setting up windows



sudo add-apt-repository main
sudo add-apt-repository universe
sudo add-apt-repository restricted
sudo add-apt-repository multiverse

sudo apt-get update


winrm get winrm/config/Service
winrm get winrm/config/Winrs
https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html


Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name Shell -Value 'PowerShell.exe -NoExit'

#winrm on windows

apt install python-pip
pip install "pywinrm>=0.3.0"

<#
    Basic:

    ansible_user: LocalUsername
    ansible_password: Password
    ansible_connection: winrm
    ansible_winrm_transport: basic


    Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $true
    set-item -path wsman:\localhost\service\Allowunencrypted -value $true
#>

<# inventory
[win]
172.16.2.5 
172.16.2.6 

[win:vars]
ansible_user=vagrant
ansible_password=password
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore

#>


<#YAML

#http://yaml-online-parser.appspot.com/
#http://www.yamllint.com/
#https://jsonformatter.org/yaml-validator


Every YAML file should start with three dashes
Comment start with #

#>

#simple YAML

---

key1: this is first value
key2: this is second value

key: value
...

# for string we can use " , '    quotes are not required but in case of complexity we should use it.
# to escape character we need to use /

# Example 2 mutiple line string
---

key1: |
 this is line 
 across multiple 
 lines spread.
 ...
 # Example 3 mutiple line string
---

key2: >
 this is line 
 across multiple 
 lines spread.
...

  # Example 4 mutiple line string
---

key2: >-
 this is line 
 across multiple 
 lines spread.
 ...


   # Example 5 mutiple line string
---

key3: 2
 ...

 #if you want to represent number as string add quotes

 
# Example 6 mutiple line string

---
statement1:false
statement2:False
statement3:no
statement4:No
statement5: FALSE

...
same stands for True, true, TRUE , on , ON, On

# to represent list

---
- listitem1
- listitem2
...

#we can also use key value like below

{key1: value1,key2: value2}


#we can use list as below

[listitem1,listitem2]


#Check below
---
key1: value1
- example list 
...

---
{key1:value1}
[listentry1]
...


#try below
key1:
 - list item1
 - list item2

key2:
 - list item3
 - list item4

 # List of dictionary

- key1:
 - list item1
 - list item2

- key2:
 - list item3
 - list item4

# check out the error is above


check out little complex 

dictionary1:
 - child dictionary1
  - subchild list1
  - subchild list2
 - child dictionary2
  - subchild list3
  - subchild list4

Now check
dictionary1:
 - childdictionary1:
   - subchild list1
   - subchild list2
 - childdictionary2:
   - subchild list3
   - subchild list4


Create list of roles
Web Servers
1) WebServer
2) Telnet
3) SMTP
4) DFS




Servers
A) WebServer
1) WebServer
2) Telnet
3) SMTP
4) DFS

B) DBServer
1) .net 3.5
2) Telnet
3) Cluster
          
          















Answers

Our Web Server:
 - WebServer
 - Telnet
 - SMTP
 - DFS










 Servers
- WebServer:
   WebServer
   Telnet
   SMTP
   DFS

- DBServer:
  .net 3.5
  Telnet
  Cluster

- Webserver:
  Web: install
  telnet: remove
  partition:
    - C
    - D


ad-hoc command

ansible {hosts group} -m {modulename } -a "{Module Args}" -C "{use this if you just want to check}" -i {Inventory file} -o {one line output} -k {connection password} -u {user} -v -vv -vvv {verbosity level}
-c {connection type} 

Iventory

[windows]
winclient

[windows:vars]
ansible_user= ""
ansible_password= ""
ansible_port= 5986
ansible_conenction= winrm
ansible_winrm_server_cert_validation= ignore



now we can run commands 
ansible windows -i hosts -m raw -a "ping 8.8.8.8" -u dinesh -k 

ansible windows -i hosts -m script -a "test.ps1" -u dinesh -k












#  foo: "{{ variable }}"

  running for windows

  - name: test script module
  hosts: windows
  tasks:
    - name: run test script
      script: files/test_script.ps1

Running individual commands uses the ‘raw’ module

- name: test raw module
  hosts: windows
  tasks:
    - name: run ipconfig
      raw: ipconfig
      register: ipconfig
    - debug: var=ipconfig

how to use the win_stat module to test for file existence.

- name: test stat module
  hosts: windows
  tasks:
    - name: test stat module on file
      win_stat: path="C:/Windows/win.ini"
      register: stat_file

    - debug: var=stat_file

    - name: check stat_file result
      assert:
          that:
             - "stat_file.stat.exists"
             - "not stat_file.stat.isdir"
             - "stat_file.stat.size > 0"
             - "stat_file.stat.md5"



  

  ansible winclient -m setup

  ubuntu:

  - name: Install Nginx
  apt:
   name: nginx
   state: latest

   or

   package:
    name: nginx
    state: latest
   

Ansible-PlayBook





  #Check what is include and import


  #Check what is tag
  define various tags in yml file

  run below commands

  ansible-playbook tags.yml --tags 'TAG1'

  --tags 'TAG1,TAG2'

  ansible-palybook tags.yml --skip-tags 'TAG2'


  we can also defile tags at hosts so as if we select that then whole yml file will run

  tags:
      - always

 

 tagged

 untagged
 all


 #Roles

Roles are grouped with logical structure , making easier to share

Example Project Structure

site.yml
webservers.yml
fooservers.yml
roles/
   common/
     tasks/--- main.yml
     handlers/ --- main.yml
     files/
     templates/
     vars/ ---main.yml
     defaults/ --- main.yml
     meta/ -- main.yml

   webservers/
     tasks/
     defaults/
     meta/

tasks - contains the main list of tasks to be executed by the role.
handlers - contains handlers, which may be used by this role or even anywhere outside this role.
defaults - default variables for the role .
vars - other variables for the role .
files - contains files which can be deployed via this role.
templates - contains templates which can be deployed via this role.
meta - defines some meta data for this role. 





