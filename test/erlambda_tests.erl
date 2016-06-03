-module(erlambda_tests).
-include_lib("eunit/include/eunit.hrl").

e(A) -> erlambda:eval(A).

id_test_() ->
    ?_assertEqual([closure, [lambda, x | x], []],
                  e([lambda, x | x ])).

app_test_() ->
    [?_assertEqual([closure, [lambda, x | x], []],
                   erlambda:eval([ [lambda, x | x], [lambda, x | x] ])),
     ?_assertEqual([closure, [lambda, b | b], []],
                   e([[[lambda, f | [lambda, x | [f, x]]],
                     [lambda, a | a]] ,
                      [lambda, b | b]]))
    ].
