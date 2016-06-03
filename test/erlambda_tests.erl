%% -*- erlang-indent-level: 2; -*-
-module(erlambda_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("erlambda/include/erlambda.hrl").

e(A) -> erlambda:eval(A).

id_test_() ->
  ?_assertEqual
     (#closure{lambda=#lambda{var=x, body=x}, env=[]},
      e(#lambda{var=x, body=x})).

app_test_() ->
  [?_assertEqual
      (#closure{lambda=#lambda{var=x, body=x}, env=[]},
       e(#app{f=#lambda{var=x, body=x},
              x=#lambda{var=x, body=x}})),

   ?_assertEqual
      (#closure{lambda=#lambda{var=b,body=b},env=[]},
       e(#app{f=
                #app{f=#lambda{var=f,body= #lambda{var=x, body=#app{f=f,x=x}}},
                     x=#lambda{var=a,body=a}
                    },
              x=#lambda{var=b,body=b}
             }))
  ].
