.PHONY: build serve test install-hooks

build:
	bundle exec jekyll build

serve:
	bundle exec jekyll serve

test:
	bash tests/run.sh

install-hooks:
	git config core.hooksPath hooks
	git config notes.rewriteRef refs/notes/verify
	git config notes.rewriteMode concatenate
	@echo "Hook install complete: core.hooksPath=hooks, notes.rewriteRef=refs/notes/verify, notes.rewriteMode=concatenate"
