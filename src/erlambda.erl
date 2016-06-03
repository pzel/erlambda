%% -*- erlang-indent-level: 2; -*-
-module(erlambda).
-export([eval/1, eval/2]).
-include_lib("erlambda/include/erlambda.hrl").

-spec eval(expr()) -> expr().
eval(Expr) -> eval(Expr, []).

-spec eval(expr(), env()) -> expr().
eval(A = #app{}, Env) -> aply(eval(A#app.f, Env), eval(A#app.x,Env));
eval(L = #lambda{}, Env) -> #closure{lambda = L, env = Env};
eval(Var, Env) -> lookup(Var, Env).

-spec aply(closure(), expr()) -> expr().
aply(#closure{lambda=#lambda{var = V, body = Body}, env=E}, X) ->
  eval(Body, [{V, X}| E]).

-spec lookup(var(), env()) -> expr().
lookup(K,Env) ->
  case proplists:lookup(K,Env) of
    {K,V} -> V;
    none -> error({undefined_var, K, Env})
  end.
