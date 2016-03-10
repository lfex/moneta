PROJECT = moneta
ROOT_DIR = $(shell pwd)
REPO = $(shell git config --get remote.origin.url)
DOCS_DIR = $(ROOT_DIR)/docs
DOCS_BUILD_DIR = $(DOCS_DIR)/build
DOCS_PROD_DIR = $(DOCS_DIR)/master
SLATE_GIT_HACK = $(DOCS_DIR)/.git

compile:
	rebar3 compile

check:
	@rebar3 eunit

repl: compile
	@lfe

shell:
	@rebar3 shell

clean:
	@rebar3 clean
	@rebar3 lfe clean

.PHONY: docs

$(SLATE_GIT_HACK):
	@ln -s $(ROOT_DIR)/.git $(DOCS_DIR)

docs-setup:
	@echo "\nInstalling and setting up dependencies ..."
	@cd $(DOCS_DIR) && bundle install

devdocs:
	@echo "\nRunning development server ..."
	@cd $(DOCS_DIR) && bundle exec middleman server

docs-clean:
	@echo "\nCleaning build directory ..."
	@rm -rf $(DOCS_BUILD_DIR)

docs: docs-clean $(SLATE_GIT_HACK)
	@echo "\nBuilding docs ...\n"
	@cd $(DOCS_DIR) && bundle exec middleman build --clean

commit:
	@echo "\nCommiting changes ...\n"
	@-git commit -a && git push --all

setup-temp-repo: $(SLATE_GIT_HACK)
	@echo "\nSetting up temporary git repos for gh-pages ...\n"
	@rm -rf $(DOCS_PROD_DIR)/current $(DOCS_PROD_DIR)/.git $(DOCS_PROD_DIR)/*/.git
	@cp -r $(DOCS_BUILD_DIR) $(DOCS_PROD_DIR)/current
	@cd $(DOCS_PROD_DIR) && git init
	@cd $(DOCS_PROD_DIR) && git add * > /dev/null
	@cd $(DOCS_PROD_DIR) && git commit -a -m "Generated content." > /dev/null

teardown-temp-repo:
	@echo "\nTearing down temporary gh-pages repos ..."
	@rm $(DOCS_DIR)/.git $(DOCS_DIR)/Gemfile.lock
	@rm -rf $(DOCS_PROD_DIR)/.git $(DOCS_PROD_DIR)/*/.git

publish-docs: commit docs setup-temp-repo
	@echo "\nPublishing docs ...\n"
	@cd $(DOCS_PROD_DIR) && git push -f $(REPO) master:gh-pages
	@make teardown-temp-repo
