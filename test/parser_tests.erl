-module(parser_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").

parse(String) ->
  erlambda_parser:parse(String).

immediate_values_test_() ->
  [
   ?_assertEqual(x, parse("x")),
   ?_assertEqual(0, parse("0")),
   ?_assertEqual({}, parse("()"))
  ].

lambda_expressions_test_() ->
  [
   ?_assertEqual(#lambda{var=x, body=x}, parse("\\x -> x")),
   ?_assertEqual(#lambda{var=x, body=2}, parse("(\\x->2)")),
   ?_assertEqual(#lambda{var=x, body=#lambda{var=y, body={}}},
                 parse("(\\x-> (\\y-> ()))"))
  ].

application_test_() ->
  [
   ?_assertEqual(#app{f=f, x=x}, parse("f x")),
   ?_assertEqual(#app{f=f, x=x}, parse("(f x)"))
  ].
