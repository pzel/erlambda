-module(erlambda_parser).
-export([parse/1]).
-include_lib("erlambda/include/erlambda.hrl").

parse(String) ->
    {ok, Tokens, _} = erlambda_lexer:string(String, 0),
    {ok, Expr} = erlambda_yecc_parser:parse(Tokens),
    Expr.

