%% -*- erlang-indent-level: 2; -*-
-module(erlambda_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").
-import(erlambda, [eval/1, app/2, closure/2, lambda/2, iff/3]).

run(S) -> erlambda:eval(erlambda_parser:parse(S)).

escript_interface_test_() ->
  ?_assertEqual
     ({},
      (fun() ->
          file:write_file("/tmp/erlambda_example.tlc",
                          "(\\x:Unit->x)()"),
           erlambda:main(["/tmp/erlambda_example.tlc"])
       end)()).


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
   ?_assertEqual(1, run("if True then 1 else 0")),
   ?_assertEqual(0, run("if False then 1 else 0")),
   ?_assertEqual(1, run("if (\\x->True)()"
                        " then (\\x->x) 1"
                        " else (\\x->x) 0"))
  ].

let_test_() ->
  [
   ?_assertEqual(1, run("let x = 1 in x")),
   ?_assertEqual(7, run("let f = (\\x -> x + 5) in f 2")),
   ?_assertEqual(7, run("let h = (\\f:(Number->Number) -> f 5) in h (\\x -> x + 2)"))
  ].

prim_op_test_() ->
  [
   ?_assertEqual(3, run("(\\x -> \\y -> x + y) 2 1"))
  ].
