:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/html_write)).

:- http_handler(/, root_handler, []).
:- http_handler('/agency', agency_handler, []).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

agency_handler(Request):-
    http_parameters(Request, [sound(Sound, [oneof([c, cs, d, ds, e, f, fs, g, gs, a, as, b])]),
			      option(Option, [default(''), oneof(['', 'm', '7', 'm7', 'sus4', 'aug', 'aug7', 'dim', 'dim7'])])]),
    agency_list([Sound, Option], Agents),
    agency_form(AgencyForm),
    reply_html_page([title('Chord-Prolog')],
		    [h1('Chord-Prolog'),
		     h2('代理コード'),
		     p(Agents),
		     agency_form(AgencyForm)
		    ]).

root_handler(_):-
    agency_form(AgencyForm),
    reply_html_page([title('Chord-Prolog')],
		    [h1('Chord-Prolog'),
		     h2('代理コード'),
		     AgencyForm
		    ]).

agency_form(form('action="/agency" method="GET"',
		  [select('name="sound" size=12',[
			      option('c'),
			      option('cs'),
			      option('d'),
			      option('ds'),
			      option('e'),
			      option('f'),
			      option('fs'),
			      option('g'),
			      option('gs'),
			      option('a'),
			      option('as'),
			      option('b')]),
		   select('name="option" size=12',[
			      option(''),
			      option('m'),
			      option('7'),
			      option('m7'),
			      option('sus4'),
			      option('aug'),
			      option('aug7'),
			      option('dim'),
			      option('dim7')
			  ]),
		   input('type="submit"')
		  ])).
