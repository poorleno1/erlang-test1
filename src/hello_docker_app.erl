-module(hello_docker_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
    % Remove direct Cowboy initialization here
    hello_docker_sup:start_link().  % Supervisor will handle Cowboy startup

stop(_State) -> ok.
