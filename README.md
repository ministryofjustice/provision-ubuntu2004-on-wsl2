# Provision Ubuntu 2004 on WSL2

Automating provisioning Ubuntu 20.04 with Ansible on WSL 2

Uses ansible, in a [pipenv](https://docs.pipenv.org/), in a WSL 2 Ubuntu instance to provision locally.

Intended to be re-runnable (idempotent) to maintain and update when required.

## Getting Started

### Prerequisites

1. Windows 10
1. WSL 2 (to enable, run the below commands in an elevated powershell prompt)
3. `dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`
4. `dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`
5. `Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -NoRestart`
6. `wsl --set-default-version 2`

1. Ubuntu 20.04 installed via Windows Store.
1. [Generate an SSH key in your Ubuntu instance and add to Github](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) 
1. Clone this repo! 

### Fix known DNS issues with WSL2
1. `./scripts/fix_dns.sh -n "192.168.x.x" -h "a-host-name"` (your home router IP)

### Configure Python & pipenv (only need to do this once)

1. Install Make `sudo apt install make`
1. `sudo apt-get update`
1. `make prep`
1. `make env`

### Clone and Run (the first time)

1. `make shell`
1. `ansible-galaxy install -r requirements.yml`
1. `ansible-playbook playbook.yml -i inventory --ask-become-pass`

## Updating after adding new tasks or applications
1. `cd provision-ubuntu2004-on-wsl2`
1. `make shell`
1. `make update`

## What is Installed?

- See the [playbook.yml](playbook.yml) task: `Install apt cmd line apps` for apt packages
- [yarn](tasks/yarn.yml)
- [tfenv](tasks/tfenv.yml)
- [aws vault](tasks/aws-vault.yml)
- [rbenv](tasks/rbenv.yml)
- [kubectl](tasks/kubectl.yml)
- [eksctl](tasks/eksctl.yml)
- [helm](tasks/helm.yml)


## Notes

|Description           | Command                                                                       |
|--------------------- | ----------------------------------------------------------------------------- |
|Find all local info   | `ansible localhost -m setup`                                                  |
|Run only rbenv        | `ansible-playbook playbook.yml -i inventory --ask-become-pass --tags "rbenv"` |
|Purge deps            | `pipenv uninstall --all`                                                      |

See [vars.yml](vars.yml) to configure which tasks get run.

## References

- [Jeff Geerling's Ansible for Devops](https://leanpub.com/ansible-for-devops/c/J2V7E1SOETu3)
- See [Brad's Pipenv Crash Course](https://youtu.be/6Qmnh5C4Pmo)
- Brad's [Pipenv cheatsheet](https://gist.github.com/bradtraversy/c70a93d6536ed63786c434707b898d55)
- [Kubernetes Releases](https://kubernetes.io/releases/)
- [eksctl releases](https://github.com/weaveworks/eksctl/releases)
- [Tig: text-mode interface for Git](https://jonas.github.io/tig/)
- [AWS-VAULT](https://github.com/99designs/aws-vault/releases)
- [wsl-open](https://github.com/4U6U57/wsl-open)
