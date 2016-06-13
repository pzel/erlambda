.PHONY: all build cover dialyzer test readme
REBAR:=QUIET=1 rebar3

all: test dialyzer cover build readme

build:
	@$(REBAR) escriptize
	-@rm ./erlambda
	@cp ./_build/default/bin/erlambda .

cover:
	@$(REBAR) cover

dialyzer:
	@$(REBAR) dialyzer

test:
	@$(REBAR) eunit

readme:
	@sed -i -e'/## Example usage/,$$ d' README.md ; \
	echo '## Example usage\n\n```' >> README.md ; \
	for f in `ls test/ex*.tlc`; do \
	echo "\n$$ cat $$f"; cat $$f; echo "\n$$ ./erlambda $$f"; ./erlambda ./$$f; \
	done >> README.md 2>&1 ; \
	echo '```' >> README.md
