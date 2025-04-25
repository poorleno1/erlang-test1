-module(hello_docker_sup).
-behaviour(supervisor).

-export([start_link/0, init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_Args) ->
    ChildSpecs = [
        #{id       => cowboy_http,
          start    => {cowboy, start_clear, [http_listener, [{port, 8080}], #{env => #{dispatch => cowboy_router:compile([{'_', [{"/", hello_handler, []}]}])}}]},
          restart  => permanent}
    ],
    {ok, {#{strategy => one_for_one}, ChildSpecs}}.
