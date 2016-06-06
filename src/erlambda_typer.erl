-module(erlambda_typer).
-export([check/1, check/2]).
-include_lib("erlambda/include/erlambda.hrl").

-type type_env() :: [{atom(), type_()}].

-spec check (expr(), type_env()) -> type_().
check(E,_) when is_number(E) -> erlambda_types:'Number'();
check(B,_) when ?is_boolean(B) -> erlambda_types:'Boolean'();
check({},_) -> erlambda_types:'Unit'();
check(#lambda{} = L, Env) -> type_fun(L, Env);

check(Var, Env) when is_atom(Var) ->
  case proplists:lookup(Var,Env) of
    {Var,T} -> T;
    none -> any_type
  end.

-spec check (expr()) -> type_().
check(Expr) -> check(Expr, default_env()).

-spec default_env() -> type_env().
default_env() -> [].

type_fun(#lambda{var=V, body=B}, Env) ->
  erlambda_types:'Fun'(check(V,Env),check(B,Env)).


