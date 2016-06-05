Nonterminals expression.


Terminals '(' ')' ',' atom integer.


Rootsymbol expression.

expression -> atom : unatom('$1').


Erlang code.

unatom({atom, _, V}) -> V.
