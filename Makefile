.PHONY: build serve test

build:
	bundle exec jekyll build

serve:
	bundle exec jekyll serve

test:
	bash tests/run.sh
