-module(parser_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").
%-import(erlambda, [eval/1, app/2, closure/2, lambda/2, iff/3]).

parse(String) ->
  erlambda_parser:parse(String).

parsing_immediate_values_test_() ->
  [
   ?_assertEqual(x, parse("x")),
   ?_assertEqual(0, parse("0")),
   ?_assertEqual({}, parse("{}"))
  ].

parsing_lambda_expressions_test_() ->
  [
   ?_assertEqual(#lambda{var=x, body=x}, parse("(\\x -> x)")),
   ?_assertEqual(#lambda{var=x, body=2}, parse("(\\x->2)")),
   ?_assertEqual(#lambda{var=x, body= #lambda{var=y, body=3}},
                 parse("(\\x-> (\\y-> 3))"))
  ].
