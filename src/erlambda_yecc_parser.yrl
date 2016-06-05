Nonterminals expression
app lambda unit.

Terminals '\\' '(' ')' '->' atom integer.

Rootsymbol expression.

app -> expression expression : app('$1', '$2').
lambda -> '\\' atom '->' expression : lambda('$2','$4').
unit -> '(' ')' : {}.

expression -> '(' expression ')' : '$2'.
expression -> app : '$1'.
expression -> lambda : '$1'.
expression -> atom : unpack('$1').
expression -> integer : unpack('$1').
expression -> unit : '$1'.

Erlang code.

unpack({_, _, V}) -> V.
app(F,X) -> erlambda:app(F,X).
lambda(Var,Body) -> erlambda:lambda(unpack(Var),Body).
