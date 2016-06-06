
%% Records
-record(app, {f :: closure(), x :: expr()}).
-record(closure, {lambda :: lambda(), env :: env()}).
-record(lambda, {var :: var(), body :: expr()}).
-record(iff, {condition :: expr(),
              consequent :: expr(), alternative :: expr()}).
%% Types
-type app() :: #app{}.
-type bool_() :: 'True' | 'False'.
-type closure() :: #closure{}.
-type env() :: [{var(), value()}].
-type expr() :: app() | lambda() | var() | number() | unit() | iff().
-type iff() :: #iff{}.
-type lambda() :: #lambda{}.
-type type_() :: 'number' | 'boolean' | 'unit'.
-type unit() :: {}.
-type value() :: closure() | number() | bool_() | unit().
-type var() :: atom().

%% Predicates
-define(is_boolean(R), R =:= 'True'; R =:= 'False').
