-module(parser_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").

parse(String) ->
  erlambda_parser:parse(String).

immediate_values_test_() ->
  [
   ?_assertEqual(x, parse("x")),
   ?_assertEqual(0, parse("0")),
   ?_assertEqual({}, parse("()")),

   ?_assertEqual('True', parse("True")),
   ?_assertEqual('False', parse("False")),
   ?_assertError({not_boolean, 'Trulse'}, parse("Trulse"))
  ].

lambda_expressions_test_() ->
  [
   ?_assertEqual(#lambda{var= #param{name=x}, body=x},
                 parse("\\x -> x")),
   ?_assertEqual(#lambda{var= #param{name=x},
                         body=#lambda{var= #param{name=y}, body={}}},
                 parse("\\x-> \\y-> ()"))
  ].

application_test_() ->
  [
   ?_assertEqual(#app{f=f, x=x}, parse("f x")),
   ?_assertEqual(#app{f=#app{f=f, x=first},
                      x=second},
                 parse("f first second"))
  ].

iff_test_() ->
  [
   ?_assertEqual(#iff{condition=a, consequent=b, alternative=c},
                 parse("if a then b else c"))
  ].

nesting_test_() ->
  [
   ?_assertEqual(parse("x"), parse("((((((((x))))))))")),
   ?_assertEqual(parse("()"), parse("((((((((()))))))))")),
   ?_assertEqual(parse("f x"), parse("((f x))"))
  ].
