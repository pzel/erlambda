Definitions.
WS = [\s\t]
NL = \n|\r\n|\r

Rules.

if : {token, {'if', TokenLine, a(TokenChars)}}.
then : {token, {'then', TokenLine, a(TokenChars)}}.
else : {token, {else, TokenLine, a(TokenChars)}}.
let : {token, {'let', TokenLine, a(TokenChars)}}.
in : {token, {'in', TokenLine, a(TokenChars)}}.

[0-9]+        : {token, {int,  TokenLine, num(TokenChars)}}.
[a-z_]+      : {token, {var, TokenLine, a(TokenChars)}}.
[A-Z][a-z_]+ : {token, {constructor, TokenLine, a(TokenChars)}}.
\(            : {token, {'(',  TokenLine}}.
\)            : {token, {')',  TokenLine}}.
\-\>          : {token, {'->',  TokenLine}}.
\:            : {token, {':',  TokenLine}}.
\\            : {token, {'\\',  TokenLine}}.
\+            : {token, {'+', TokenLine}}.
\=            : {token, {'=', TokenLine}}.
{WS}+|{NL}+     : skip_token.

Erlang code.
a(String) -> erlang:list_to_atom(String).
num(String) -> erlang:list_to_integer(String).
