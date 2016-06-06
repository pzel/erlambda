-module(erlambda_typer_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").
-import(erlambda_types, ['Boolean'/0, 'Number'/0, 'Unit'/0]).

check(S) -> erlambda_typer:check(erlambda_parser:parse(S)).
check(S,Env) -> erlambda_typer:check(erlambda_parser:parse(S), Env).

immediate_values_test_() ->
  [
   ?_assertEqual('Number'(), check("2")),
   ?_assertEqual('Boolean'(), check("True")),
   ?_assertEqual('Boolean'(), check("False")),
   ?_assertEqual('Unit'(), check("()"))
  ].

binding_from_type_environment_test_() ->
  [
   ?_assertEqual(any_type, check("x", [])),
   ?_assertEqual('Number'(), check("x", [{x, 'Number'()}])),
   ?_assertEqual(#'Fun'{input='Number'(), output='Number'()},
                 check("\\x -> x", [{x, 'Number'()}]))
  ].
