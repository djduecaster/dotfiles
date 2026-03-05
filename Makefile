SHELL := /usr/bin/env bash
.DEFAULT_GOAL := help

.PHONY: help bootstrap install doctor tailscale-ssh update

help: ## Show available commands
	@grep -E '^[a-zA-Z0-9_.-]+:.*## ' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*## "}; {printf "%-15s %s\n", $$1, $$2}'

bootstrap: ## Install/check prerequisites and link configs
	@./scripts/bootstrap

install: ## Link dotfiles into home directory
	@./install.sh

doctor: ## Run setup health checks
	@./scripts/doctor

tailscale-ssh: ## Regenerate ~/.ssh/config.tailscale from tailscale status
	@./scripts/generate-tailscale-ssh-config.sh

update: ## Refresh generated SSH config and run health checks
	@./scripts/generate-tailscale-ssh-config.sh || true
	@./scripts/doctor
