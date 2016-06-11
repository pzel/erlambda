Nonterminals expression
app bool ifexpression lambda unit.

Terminals '\\' ':' '(' ')' '->' atom integer var if then else.


Rootsymbol expression.

Left 80 app.
app -> expression expression : app('$1', '$2').
bool -> var : assert_bool(unpack('$1')).
lambda -> '\\' atom '->' expression : untyped_lambda('$2','$4').
lambda -> '\\' atom ':' var '->' expression : typed_lambda('$2','$4', '$6').
unit -> '(' ')' : {}.

ifexpression -> if expression then expression else expression :
                iff('$2', '$4', '$6').

expression -> '(' expression ')' : '$2'.
expression -> app : '$1'.
expression -> lambda : '$1'.
expression -> bool : '$1'.
expression -> ifexpression : '$1'.

expression -> atom : unpack('$1').
expression -> integer : unpack('$1').
expression -> unit : '$1'.


Erlang code.

app(F,X) -> erlambda:app(F,X).
assert_bool(B) when B =:= 'True'; B =:= 'False' -> B;
assert_bool(X) -> error({not_boolean, X}).
untyped_lambda(Var,Body) ->
  erlambda:lambda(unpack(Var),any_type,Body).
typed_lambda(Var, Type, Body) ->
  T = erlambda_types:from_atom(unpack(Type)),
  erlambda:lambda(unpack(Var), T,Body).
iff(A,B,C) -> erlambda:iff(A,B,C).
unpack({_, _, V}) -> V.
