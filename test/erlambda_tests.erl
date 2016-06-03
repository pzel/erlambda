%% -*- erlang-indent-level: 2; -*-
-module(erlambda_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").
-import(erlambda, [eval/1, app/2, closure/2, lambda/2]).

id_test_() ->
  ?_assertEqual
     (closure(lambda(x,x), []),
      eval(lambda(x,x))).

app_test_() ->
  [?_assertEqual
      (closure(lambda(x,x), []),
       eval(app(lambda(x,x), lambda(x,x)))),

   ?_assertEqual
      (closure(lambda(b,b),[]),
       eval(app(app(lambda(f, lambda(x, app(f,x))),
                    lambda(a,a)),
              lambda(b,b))))
  ].
