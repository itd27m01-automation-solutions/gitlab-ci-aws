.ONESHELL:
SHELL = /bin/bash

default: validate

.PHONY: validate
validate:
	@terragrunt validate-all --terragrunt-non-interactive
	$(MAKE) clean

.PHONY: plan
plan:
	@terragrunt plan-all --terragrunt-non-interactive

.PHONY: apply
apply:
	@terragrunt apply-all --terragrunt-non-interactive 2>&1 | grep -v 'terragrunt'

.PHONY: destroy
destroy:
	@terragrunt destroy-all
	$(MAKE) clean

.PHONY: clean
clean:
	@find . -name .terragrunt-cache -type d -prune -exec rm -rf {} \;
	@find . -name .terraform -type d -prune -exec rm -rf {} \;
