.PHONY: all cover dialyzer test

all: test dialyzer cover

cover:
	rebar3 cover

dialyzer:
	rebar3 dialyzer

test:
	rebar3 eunit

