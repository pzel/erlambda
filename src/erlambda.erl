%% -*- erlang-indent-level: 2; -*-
-module(erlambda).
-export([eval/1, eval/2]).

eval(Expr) -> eval(Expr, []).

eval([F,X], Env) -> app(eval(F,Env),eval(X,Env));
eval([lambda, _ | _] = C, Env) -> [closure, C, Env];
eval(Var, Env) -> lookup(Var, Env).

app([closure, [lambda, Var | Body], Env], X) ->
  eval(Body, [{Var, X}|Env]).

lookup(K,Env) ->
  case proplists:lookup(K,Env) of
    {K,V} -> V;
    none -> error({undefined_var, K, Env})
  end.
