-module(erlambda_types).
-include_lib("erlambda/include/erlambda.hrl").
-export(['Boolean'/0, 'Fun'/2, 'Number'/0, 'Unit'/0]).
-export([from_atom/1]).

-spec from_atom(atom()) -> type_().
from_atom(A) when is_atom(A) ->
  apply(?MODULE, A, []).

-spec 'Boolean'() -> 'Boolean'().
'Boolean'() -> #'Boolean'{}.

-spec 'Fun'(type_(), type_()) -> 'Fun'().
'Fun'(I,O) -> #'Fun'{input=I, output=O}.

-spec 'Number'() -> 'Number'().
'Number'() -> #'Number'{}.

-spec 'Unit'() -> 'Unit'().
'Unit'() -> #'Unit'{}.
