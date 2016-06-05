-module(erlambda_parser).
-export([parse/1]).
-include_lib("erlambda/include/erlambda.hrl").

parse(String) ->
    {ok, Tokens, _} = erl_scan:string
                        (String, 0,
                         [{reserved_word_fun, fun reserved/1}]),
    {ok, Expr} = erlambda_yecc_parser:parse(Tokens),
    Expr.

reserved(_A) -> false.

