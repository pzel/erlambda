%% -*- erlang-indent-level: 2; -*-
-module(erlambda_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").
-import(erlambda, [eval/1, app/2, closure/2, lambda/2]).

applying_lambdas_test_() ->
  [
   ?_assertEqual
      (closure(lambda(x,x), []),
       eval(lambda(x,x))),

   ?_assertEqual
      (closure(lambda(x,x), []),
       eval(app(lambda(x,x), lambda(x,x)))),

   ?_assertEqual
      (closure(lambda(b,b),[]),
       eval(app(app(lambda(f, lambda(x, app(f,x))),
                    lambda(a,a)),
                lambda(b,b))))
  ].

immediate_values_numbers_test_() ->
  [
   ?_assertEqual(2, eval(2)),
   ?_assertEqual(23, eval(app(lambda(b,b), 23)))
  ].

immediate_values_booleans_test_() ->
  [
   ?_assertEqual('True', eval('True')),
   ?_assertEqual('False', eval('False')),
   ?_assertEqual('False', eval(app(lambda(x,x), 'False')))
  ].

immediate_values_unit_test_() ->
  [
   ?_assertEqual({}, eval({})),
   ?_assertEqual({}, eval(app(lambda(b,b), {})))
  ].
