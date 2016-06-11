.PHONY: all build cover dialyzer test
REBAR:=QUIET=1 rebar3

all: test dialyzer cover build

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

