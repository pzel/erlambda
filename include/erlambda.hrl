
%% Records
-record(app, {f :: closure(), x :: expr()}).
-record(closure, {lambda :: lambda(), env :: env()}).
-record(lambda, {var :: var(), body :: expr()}).
-record(iff, {condition :: expr(),
              consequent :: expr(), alternative :: expr()}).

%% Expressions (Host langauge types)
-type app() :: #app{}.
-type bool_() :: 'True' | 'False'.
-type closure() :: #closure{}.
-type env() :: [{var(), value()}].
-type expr() :: app() | lambda() | var() | number() | unit() | iff().
-type iff() :: #iff{}.
-type lambda() :: #lambda{}.
-type unit() :: {}.
-type value() :: closure() | number() | bool_() | unit().
-type var() :: atom().

%% Predicates
-define(is_boolean(R), R =:= 'True'; R =:= 'False').


%% Types (guest language types)
-type type_() :: 'Number'() | 'Boolean'() | 'Unit'() | 'Fun'().

-record('Boolean', {}).
-type 'Boolean'() :: #'Boolean'{}.

-record('Fun', {input :: type_(), output :: type_()}).
-type 'Fun'() :: #'Fun'{}.

-record('Number', {}).
-type 'Number'() :: #'Number'{}.

-record('Unit', {}).
-type 'Unit'() :: #'Unit'{}.

