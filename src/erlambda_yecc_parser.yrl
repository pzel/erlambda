Nonterminals expression
app bool ifexpression lambda funtype unit valuetype.

Terminals '\\' ':' '(' ')' '->' int var constructor if then else.


Rootsymbol expression.

Left 80 app.
app -> expression expression : app('$1', '$2').
bool -> constructor : assert_bool(unpack('$1')).
lambda -> '\\' var '->' expression : untyped_lambda('$2','$4').
lambda -> '\\' var ':' valuetype '->' expression : valuetyped_lambda('$2','$4','$6').
lambda -> '\\' var ':' funtype '->' expression : funtyped_lambda('$2','$4','$6').
unit -> '(' ')' : {}.
funtype -> '(' constructor '->' constructor ')' : {unpack('$2'), unpack('$4')}.
valuetype -> constructor : '$1'.

ifexpression -> if expression then expression else expression :
                iff('$2', '$4', '$6').

expression -> '(' expression ')' : '$2'.
expression -> app : '$1'.
expression -> lambda : '$1'.
expression -> bool : '$1'.
expression -> ifexpression : '$1'.

expression -> var : unpack('$1').
expression -> int : unpack('$1').
expression -> unit : '$1'.


Erlang code.

app(F,X) -> erlambda:app(F,X).

assert_bool(B) when B =:= 'True'; B =:= 'False' -> B;

assert_bool(X) -> error({not_boolean, X}).

untyped_lambda(Var,Body) ->
  erlambda:lambda(unpack(Var),any_type,Body).

funtyped_lambda(Var, {In,Out}, Body) ->
  T = erlambda_types:fun_from_atoms(In, Out),
  erlambda:lambda(unpack(Var), T, Body).

valuetyped_lambda(Var, Type, Body) ->
  T = erlambda_types:from_atom(unpack(Type)),
  erlambda:lambda(unpack(Var), T,Body).

iff(A,B,C) -> erlambda:iff(A,B,C).

unpack({_, _, V}) -> V.
