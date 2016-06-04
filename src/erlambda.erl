%% -*- erlang-indent-level: 2; -*-
-module(erlambda).
-export([eval/1, eval/2]).
-export([app/2, closure/2, lambda/2, iff/3]).
-include_lib("erlambda/include/erlambda.hrl").

-spec eval(expr()) -> value().
eval(Expr) -> eval(Expr, []).

-spec eval(expr(), env()) -> value().
eval(A = #app{f=F,x=X}, Env) -> aply(eval(F, Env), eval(X,Env));
eval(L = #lambda{}, Env) -> #closure{lambda = L, env = Env};
eval(N, _) when is_number(N) -> N;
eval(B, _) when B =:= 'True'; B =:= 'False' -> B;
eval({}, _)  -> {};
eval(I = #iff{}, Env) -> eval_iff(I, Env);
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

-spec iff(expr(), expr(), expr()) -> expr().
iff(A,B,C) -> #iff{condition=A, consequent=B, alternative=C}.

-spec lambda(var(), expr()) -> lambda().
lambda(V,B) -> #lambda{var=V, body=B}.

% Special form evaluation
-spec eval_iff(iff(), env()) -> value().
eval_iff(I, Env) ->
  case eval(I#iff.condition, Env) of
    'True' -> eval(I#iff.consequent, Env);
    'False' -> eval(I#iff.alternative, Env)
  end.
