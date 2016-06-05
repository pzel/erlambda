Nonterminals expression.


Terminals '(' ')' ',' atom integer.


Rootsymbol expression.

expression -> atom : unpack('$1').
expression -> integer : unpack('$1').


Erlang code.

unpack({_, _, V}) -> V.
