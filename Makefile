#!make


prep:
			sudo apt install --yes python3-pip && sudo pip3 install pipenv		

update:
			ansible-playbook playbook.yml -i inventory --ask-become-pass

shell:
			pipenv shell

.PHONY: prep update shell