.PHONY: all cover dialyzer test
REBAR:=QUIET=1 rebar3

all: test dialyzer cover

cover:
	@$(REBAR) cover

dialyzer:
	@$(REBAR) dialyzer

test:
	@$(REBAR) eunit

