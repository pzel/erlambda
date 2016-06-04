
-record(app, {f :: closure(), x :: expr()}).
-type app() :: #app{}.

-record(closure, {lambda :: lambda(), env :: env()}).
-type closure() :: #closure{}.

-record(lambda, {var :: var(), body :: expr()}).
-type lambda() :: #lambda{}.

-type bool_() :: 'True' | 'False'.

-type unit() :: {}.

-type var() :: atom().
-type value() :: closure() | number() | bool_() | unit().
-type env() :: [{var(), value()}].
-type expr() :: app() | lambda() | var().

