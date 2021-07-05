#!make


prep:
			sudo apt install --yes python3-pip && sudo pip3 install pipenv

env:
			pipenv install --dev		

update:
			ansible-playbook playbook.yml -i inventory --ask-become-pass

shell:
			pipenv shell

.PHONY: prep update shell