> VMWare - Initial Setup

- Workstation VM
	- Name
		- kube-workstation
	- Resources
		- RAM: 6144
	- OS
		- Ubuntu-24.04.2-live-server-amd64
- Component VMs
	- Names
		- kube-loadbalancer
		- kube-controller-1
		- kube-controller-2
		- kube-worker-1
		- kube-worker-2
	- Resources
		- RAM: 2048
	- OS
		- Ubuntu-24.04.2-live-server-amd64
* * *
> Create VMs

- **VMWare Workstation**
	- **Power on the virtual machine after creation**
		- `Uncheck`
	- Edit virtual machine settings > Options > Advanced > **Disable side channel mitigations for Hyper-V enabled hosts=**`Check`
	- Profile Configuration
		- name: <USER>
		- servers name: kube-<COMPONENT>
		- username: <USER>
		- password: <PASSWORD>
	- SSH Configuration
		- Install OpenSSH Server=`Check`
* * *
> Setup SSH

- **Host to kube-workstation**
	- **WSL [~]**
		- `sudo vi /etc/hosts`
		- `ssh-keygen -f .ssh/ed25519-$USER -t ed25519 -C "kube-workstation-access" -N ""`
		- `ssh-copy-id -i ./ed25519-$USER.pub kube-workstation`
		- `vi .ssh/config`
			- [WSL:~/.ssh/config]
	- **VSCode [/mnt/c/Users/<USER>/.ssh]**
		- Add to `C:\Windows\System32\drivers\etc\hosts`
			- [VSCode:C:\Windows\System32\drivers\etc\hosts]
		- `cp ~/.ssh/ed25519-$USER .`
		- `vi config`
			- [VSCode:~/.ssh/config]
- **kube-workstation to kube-components**
	- **kube-workstation [~]**
 		- `sudo vi /etc/hosts`
		- `ssh-keygen -f ~/.ssh/ed25519-$USER -t ed25519 -C "kube-components-access" -N ""`
		- `for ip in $(grep "kube-" /etc/hosts | awk '{print $1}'); do ssh-copy-id -i ~/.ssh/ed25519-$USER.pub $ip; done`
		- `vi .ssh/config`
			- [kube-workstation:~/.ssh/config]
- **kube-workstation to Github**
	- **kube-workstation [~]**
		- `ssh-keygen -f ~/.ssh/ed25519-Github -t ed25519 -C "example@email" -N ""`
		- `vi .ssh/config`
			- [kube-workstation:~/.ssh/config]
		- `ssh Github`
	- **Github [Profile]**
		- Settings > SSH and GPG Keys > New SSH key
		- Add new SSH Key
			- Title
				- kubernetes-the-hard-way-kube-workstation
			- Key
				- `cat .ssh/ed25519-Github.pub`
```
hosts

<COMPONENT_IP> kube-workstation
<COMPONENT_IP> kube-controller-1
<COMPONENT_IP> kube-controller-2
<COMPONENT_IP> kube-worker-1
<COMPONENT_IP> kube-worker-2
<COMPONENT_IP> kube-loadbalancer
```
```
[WSL:/etc/hosts]

> # Kubernetes the hard way
> 192.168.138.133 kube-workstation

[WSL:~/.ssh/config]

> Host kube-workstation
>  HostName kube-workstation
>  IdentityFile ~/.ssh/ed25519-<USER>
```
```
[VSCode:C:\Windows\System32\drivers\etc\hosts]

> 192.168.138.133 kube-workstation

[VSCode:~/.ssh/config]

> Host kube-workstation
>  HostName kube-workstation
>  User <USER>
>  IdentityFile C:\Users\apost\.ssh\ed25519-<USER>
```
```
[kube-workstation:/etc/hosts]

> # Kubernetes the hard way
> 192.168.138.134 kube-controller-1
> 192.168.138.130 kube-controller-2
> 192.168.138.131 kube-worker-1
> 192.168.138.132 kube-worker-2
> 192.168.138.128 kube-loadbalancer

[kube-workstation:~/.ssh/config]

> Host kube-workstation
>  HostName kube-workstation
>  IdentityFile ~/.ssh/ed25519-<USER>
>
> Host kube-controller-1
>  HostName kube-controller-1
>  IdentityFile ~/.ssh/ed25519-<USER>
>
> Host kube-controller-2
>  HostName kube-controller-2
>  IdentityFile ~/.ssh/ed25519-<USER>
>
> Host kube-worker-1
>  HostName kube-worker-1
>  IdentityFile ~/.ssh/ed25519-<USER>
>
> Host kube-worker-2
>  HostName kube-worker-2
>  IdentityFile ~/.ssh/ed25519-<USER>
>
> Host kube-loadbalancer
>  HostName kube-loadbalancer
>  IdentityFile ~/.ssh/ed25519-<USER>
>
> Host Github
>  HostName github.com
>  USER git
>  IdentityFile ~/.ssh/ed25519-Github
```
* * *
> Git clone && init setup

- **kube-workstation [~]**
	- `mkdir projects`
	- `cd projects`
	- `git clone ssh://Github/<USER>/kubernetes-the-hard-way-ansible`
	-  `git config --global user.email example@email`
	-  `git config --global user.name <USER>>`