%% -*- erlang-indent-level: 2; -*-
-module(erlambda).
-export([main/1, run_file/1]).
-export([eval/1, eval/2]).
-export([app/2, closure/2, lambda/2, lambda/3, iff/3, primop/3]).
-include_lib("erlambda/include/erlambda.hrl").


-spec main(list()) -> string().
main([Filename|_]) ->
  R = try run_file(Filename) catch _:M -> M end,
  erlang:display(R),
  R.

-spec run_file(list()) -> value().
run_file(Filename) ->
  {ok, Contents} = file:read_file(Filename),
  AST = erlambda_parser:parse(binary_to_list(Contents)),
  _Type = erlambda_typer:check(AST),
  ?MODULE:eval(AST, []).

-spec eval(expr()) -> value().
eval(Expr) -> eval(Expr, []).

-spec eval(expr(), env()) -> value().
eval(#app{f=F,x=X}, Env) -> aply(eval(F, Env), eval(X,Env));
eval(#primop{op=F,args=As}, Env) -> aply_prim(F, [eval(A,Env)||A <- As]);
eval(#lambda{} = L, Env) -> #closure{lambda = L, env = Env};
eval(N, _) when is_number(N) -> N;
eval(B, _) when ?is_boolean(B) -> B;
eval({}, _)  -> {};
eval(I = #iff{}, Env) -> eval_iff(I, Env);
eval(Reference, Env) -> lookup(Reference, Env).

-spec aply(value(), value()) -> value().
aply(#closure{lambda=#lambda{var= #param{name=V}, body= Body}, env=E}, X) ->
  eval(Body, [{V, X}| E]).

-spec aply_prim(atom(), [value()]) -> value().
aply_prim('+', [X,Y]) -> X + Y.

-spec lookup(ref(), env()) -> value().
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

-spec lambda(atom(), expr()) -> lambda().
lambda(V,B) -> lambda(V,any_type,B).

-spec lambda(atom(), type_(), expr()) -> lambda().
lambda(V,T,B) -> #lambda{var=param(V, T), body=B}.

-spec param(atom(), type_()) -> param().
param(N,T) -> #param{name=N, type=T}.

-spec primop(atom(), expr(), expr()) -> expr().
primop(F,A1,A2) -> #primop{op=F, args=[A1,A2]}.


% Special form evaluation
-spec eval_iff(iff(), env()) -> value().
eval_iff(I, Env) ->
  case eval(I#iff.condition, Env) of
    'True' -> eval(I#iff.consequent, Env);
    'False' -> eval(I#iff.alternative, Env)
  end.
