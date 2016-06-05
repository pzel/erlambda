Nonterminals expression unit.


Terminals '(' ')' ',' '{' '}' atom integer.


Rootsymbol expression.

unit -> '{' '}' : {}.
expression -> atom : unpack('$1').
expression -> integer : unpack('$1').
expression -> unit : '$1'.

Erlang code.

unpack({_, _, V}) -> V.
