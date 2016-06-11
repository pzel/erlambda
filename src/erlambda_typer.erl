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
check(#param{name = N, type = T}, Env) -> type_param(N, T, Env);
check(V, Env) when is_atom(V) -> type_var(V, Env).

-spec check (expr()) -> type_().
check(Expr) -> check(Expr, default_env()).

-spec default_env() -> type_env().
default_env() -> [].

%% Type rules

type_app(#app{f=F, x=X} = A, Env) ->
  T0 = check(F, Env),
  T1 = check(X, Env),
  case T0 of
    #'Fun'{input=T1, output=TOutput} -> TOutput;
    _ -> throw({constraint_failed, {A, T0, T1}})
  end.

type_fun(#lambda{var=V, body=B}, Env) ->
  ArgType = check(V,Env),
  InnerEnv = [{V#param.name, ArgType}|Env],
  erlambda_types:'Fun'(ArgType, check(B,InnerEnv)).

type_param(Name, SuppliedType, Env) ->
  case {SuppliedType, check(Name, Env)} of
    {any_type, Inferred} -> Inferred;
    {SuppliedType, any_type} -> SuppliedType;
    {SuppliedType, SuppliedType} -> SuppliedType;
    {SuppliedType, Different} ->
      throw({conflicting_types,
             Name,
             {supplied, SuppliedType},
             {inferred, Different}})
  end.

type_var(Var, Env) ->
  case proplists:lookup(Var,Env) of
    {Var,T} -> T;
    none -> any_type
  end.
