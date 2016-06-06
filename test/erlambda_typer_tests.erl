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
   ?_assertEqual('Number'(), check("x", [{x, 'Number'()}]))
  ].

lambda_input_output_test_() ->
  [
   ?_assertEqual(#'Fun'{input='Number'(), output='Number'()},
                 check("\\x -> x", [{x, 'Number'()}])),
   ?_assertEqual(#'Fun'{input='Number'(), output='Unit'()},
                 check("\\x -> ()", [{x, 'Number'()}])),
   ?_assertEqual(#'Fun'{input='Number'(), output='Boolean'()},
                 check("\\x -> z", [{x, 'Number'()}, {z, 'Boolean'()}]))
  ].

application_test_() ->
  [
   ?_assertEqual(
      'Number'(),
      check("(\\x -> y) z",
            [{x, 'Boolean'()}, {y, 'Number'()}, {z, 'Boolean'()}])),

   ?_assertThrow(
      {constraint_failed, {#app{}, #'Fun'{}, #'Unit'{}}},
      check("(\\x -> y) z",
            [{x, 'Boolean'()}, {y, 'Number'()}, {z, 'Unit'()}]))
  ].

