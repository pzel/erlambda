-module(erlambda_typer).
-export([check/1, check/2]).
-include_lib("erlambda/include/erlambda.hrl").

-type type_env() :: [{atom(), type_()}].

-spec check (expr(), type_env()) -> type_().
check(E,_) when is_number(E) -> erlambda_types:'Number'();
check(B,_) when ?is_boolean(B) -> erlambda_types:'Boolean'();
check({},_) -> erlambda_types:'Unit'();
check(#lambda{} = L, Env) -> type_fun(L, Env);
check(#app{} = A, Env) -> type_app(A, Env);
check(#primop{} = P, Env) -> type_primop(P, Env);
check(#param{name = N, type = T}, Env) -> type_param(N, T, Env);
check(#lett{} = L, Env) -> type_lett(L, Env);
check(V, Env) when is_atom(V) -> type_var(V, Env).

-spec check (expr()) -> type_().
check(Expr) -> check(Expr, default_env()).

-spec default_env() -> type_env().
default_env() -> [].

%% Type rules

type_app(#app{f = F, x=X} = A, Env) ->
  T0 = check(F, Env),
  T1 = check(X, Env),
  case {T0,T1} of
    {#'Fun'{input=T1, output=TOutput}, _} -> TOutput;
    %% very poor man's inference.
    {#'Fun'{input=#'Fun'{output=O2}}, #'Fun'{input=_, output=any_type}} -> O2;
    _ -> throw({constraint_failed, {A, T0, T1}})
  end.

type_lett(#lett{var=Var, val=Val, 'in'=Body}, Env) ->
  TVal = check(Val, Env),
  check(Body, [{Var, TVal}|Env]).

type_primop(#primop{op='+', args=[X,Y]}, Env) ->
  TX = check(X, Env),
  TY = check(Y, Env),
  case {TX,TY} of
    {#'Number'{}, #'Number'{}} -> #'Number'{};
    _ -> throw({constraint_failed, {'+', TX, TY}}) end.

type_fun(#lambda{var=V, body=B}, Env) ->
  ArgType = check(V,Env),
  InnerEnv = [{V#param.name, ArgType}|Env],
  erlambda_types:'Fun'(ArgType, check(B,InnerEnv)).

type_param(Name, any_type, Env) -> check(Name, Env);
type_param(_, SuppliedType, _) -> SuppliedType.

type_var(Var, Env) ->
  case proplists:lookup(Var,Env) of
    {Var,T} -> T;
    none -> any_type
  end.
