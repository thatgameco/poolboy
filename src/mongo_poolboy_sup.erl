%% Poolboy - A hunky Erlang worker pool factory

-module(mongo_poolboy_sup).
-behaviour(supervisor).

-export([start_link/2, init/1]).

start_link(Mod, Args) ->
    supervisor:start_link(?MODULE, {Mod, Args}).

init({Mod, Args}) when is_atom(Mod)->
    {ok, {{simple_one_for_one, 0, 1},
          [{Mod, {Mod, start_link, [Args]},
            temporary, 5000, worker, [Mod]}]}};
init({{Mod, Fun}, Args}) ->
    {ok, {{simple_one_for_one, 0, 1},
        [{Mod, {Mod, Fun, [Args]},
            temporary, 5000, worker, [Mod]}]}}.
