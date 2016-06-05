-module(parser_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").
%-import(erlambda, [eval/1, app/2, closure/2, lambda/2, iff/3]).

parse(String) ->
    erlambda_parser:parse(String).

parsing_immediate_values_test_() ->
  [
   ?_assertEqual(x, parse("x"))
  ].
