.PHONY: dialyzer test

all: test dialyzer

test:
	rebar3 eunit

dialyzer:
	rebar3 dialyzer
