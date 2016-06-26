
%% Records
-record(app, {f :: closure(), x :: expr()}).
-record(closure, {lambda :: lambda(), env :: env()}).
-record(lambda, {var :: param(), body :: expr()}).
-record(iff, {condition :: expr(),
              consequent :: expr(), alternative :: expr()}).
-record(lett, {var :: atom(),
               val :: expr(),
               in :: expr()}).
-record(param, {name :: atom(),
                type = any_type :: type_()}).
-record(primop, {op :: atom(),
                 args :: [expr()]}).

%% Expressions (Host langauge types)
-type app() :: #app{}.
-type bool_() :: 'True' | 'False'.
-type closure() :: #closure{}.
-type env() :: [{atom(), value()}].
-type expr() :: app() | lambda() | param() | number() | unit() | iff() | ref().
-type iff() :: #iff{}.
-type lett() :: #lett{}.
-type lambda() :: #lambda{}.
-type param() :: #param{}.
-type primop() :: #primop{}.
-type ref() :: atom().
-type unit() :: {}.
-type value() :: closure() | number() | bool_() | unit().

%% Predicates
-define(is_boolean(R), R =:= 'True'; R =:= 'False').

%% Types (guest language types)
-type type_() :: 'Number'() | 'Boolean'() | 'Unit'() | 'Fun'()
               | any_type.

-record('Boolean', {}).
-type 'Boolean'() :: #'Boolean'{}.

-record('Fun', {input :: type_(), output :: type_()}).
-type 'Fun'() :: #'Fun'{}.

-record('Number', {}).
-type 'Number'() :: #'Number'{}.

-record('Unit', {}).
-type 'Unit'() :: #'Unit'{}.
