-module(erlambda_typer_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").

check(S) -> erlambda_typer:check(erlambda_parser:parse(S)).

immediate_values_test_() ->
  [
   ?_assertEqual(number, check("2")),
   ?_assertEqual(boolean, check("True")),
   ?_assertEqual(boolean, check("False")),
   ?_assertEqual(unit, check("()"))
  ].
