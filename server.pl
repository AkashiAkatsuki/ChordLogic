:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/html_write)).

:- http_handler(/, root_handler, []).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

root_handler(_):-
    reply_html_page([title('Chord-Prolog')],
		    [h1('Chord-Prolog'),
		     p('hello world')
		    ]).
