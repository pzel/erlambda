
-type var() :: atom().
-type env() :: [{var(), expr()}].

-record(app, {f :: closure(), x :: expr()}).
-type app() :: #app{}.

-record(closure, {lambda :: lambda(), env :: env()}).
-type closure() :: #closure{}.

-record(lambda, {var :: var(), body :: expr()}).
-type lambda() :: #lambda{}.

-type expr() :: app() | lambda() | var() | closure().