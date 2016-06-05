Nonterminals expression
lambda fun
unit.

Terminals '\\' '(' ')' ',' '->' '{' '}' atom integer.

Rootsymbol expression.

unit -> '{' '}' : {}.
lambda -> '(' '\\' atom '->' expression ')' : mk_lambda(unpack('$3'),'$5').

expression -> lambda : '$1'.
expression -> atom : unpack('$1').
expression -> integer : unpack('$1').
expression -> unit : '$1'.

Erlang code.

unpack({_, _, V}) -> V.
mk_lambda(Var,Body) -> erlambda:lambda(Var,Body).
