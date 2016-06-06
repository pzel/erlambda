-module(erlambda_typer).
-export([check/1]).
-include_lib("erlambda/include/erlambda.hrl").

-spec check (expr()) -> type_().
check(E) when is_number(E) -> number;
check(B) when ?is_boolean(B) -> boolean;
check({}) -> unit.
