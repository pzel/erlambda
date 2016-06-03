%% -*- erlang-indent-level: 2; -*-
-module(erlambda).
-export([eval/1, eval/2]).
-export([app/2, closure/2, lambda/2]).
-include_lib("erlambda/include/erlambda.hrl").

-spec eval(expr()) -> value().
eval(Expr) -> eval(Expr, []).

-spec eval(expr(), env()) -> value().
eval(A = #app{}, Env) -> aply(eval(A#app.f, Env), eval(A#app.x,Env));
eval(L = #lambda{}, Env) -> #closure{lambda = L, env = Env};
eval(Var, Env) -> lookup(Var, Env).

-spec aply(value(), value()) -> value().
aply(#closure{lambda=#lambda{var = V, body = Body}, env=E}, X) ->
  eval(Body, [{V, X}| E]).

-spec lookup(var(), env()) -> value().
lookup(K,Env) ->
  case proplists:lookup(K,Env) of
    {K,V} -> V;
    none -> error({undefined_var, K, Env})
  end.

% Constructors
-spec app(expr(), expr()) -> app().
app(F,X) -> #app{f=F, x=X}.

-spec closure(lambda(), env()) -> closure().
closure(A,E) -> #closure{lambda=A,env=E}.

-spec lambda(var(), expr()) -> lambda().
lambda(V,B) -> #lambda{var=V, body=B}.
