%% -*- erlang-indent-level: 2; -*-
-module(erlambda_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").
-import(erlambda, [eval/1, app/2, closure/2, lambda/2, iff/3]).

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

variable_not_defined_test_() ->
  [
   ?_assertError({undefined_var, v, [{x, {}}]},
                 eval(app(lambda(x,v), {})))
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


iff_test_() ->
  [
   ?_assertEqual(1, eval(iff('True', 1, 0))),
   ?_assertEqual(0, eval(iff('False', 1, 0))),
   ?_assertEqual(1, eval(iff(app(lambda(x,x), 'True'),
                             app(lambda(x,x), 1),
                             app(lambda(x,x), 0))))
  ].
