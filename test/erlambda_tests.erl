%% -*- erlang-indent-level: 2; -*-
-module(erlambda_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").
-import(erlambda, [eval/1, app/2, closure/2, lambda/2, iff/3]).

run(S) -> erlambda:eval(erlambda_parser:parse(S)).

applying_lambdas_test_() ->
  [
   ?_assertEqual(closure(lambda(x,x), []),
                 run("\\x->x")),

   ?_assertEqual(closure(lambda(y,y), []),
                 run("(\\x->x) \\y->y")),

   ?_assertEqual(closure(lambda(b,b),[]),
                 run("((\\f-> \\x-> f x)(\\a->a))(\\b->b)"))
  ].

application_precedence_test_() ->
  ?_assertEqual({},
                run("(\\x -> \\y -> x) () 3")).

variable_not_defined_test_() ->
  [
   ?_assertError({undefined_var, v, [{x, {}}]},
                 run("(\\x->v)()"))
  ].

immediate_values_numbers_test_() ->
  [
   ?_assertEqual(2, run("2")),
   ?_assertEqual(23, run("(\\b->b) 23"))
  ].

immediate_values_booleans_test_() ->
  [
   ?_assertEqual('True', run("True")),
   ?_assertEqual('False', run("False")),
   ?_assertEqual('False', run("(\\x->x) False"))
  ].

immediate_values_unit_test_() ->
  [
   ?_assertEqual({}, run("()")),
   ?_assertEqual({}, run("(\\b->b) ()"))
  ].


iff_test_() ->
  [
   ?_assertEqual(1, eval(iff('True', 1, 0))),
   ?_assertEqual(0, eval(iff('False', 1, 0))),
   ?_assertEqual(1, eval(iff(app(lambda(x,x), 'True'),
                             app(lambda(x,x), 1),
                             app(lambda(x,x), 0))))
  ].
