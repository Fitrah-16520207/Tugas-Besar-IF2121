:- include('farming.pl').
:- include('fishing.pl').
:- include('inventory.pl').
:- include('item.pl').
:- include('map.pl').
:- include('marketplace.pl').
:- include('menu.pl').
:- include('pemain.pl').
:- include('quest.pl').
:- include('ranching.pl').

:- dynamic(state/1).
state(not_started).

% State dapat berupa:
% * not_started
% * free
% * finished

setState(X) :-
    retractall(state(_)),
    asserta(state(X)).

% acak(A,B,X) :-
%     real_time(RT),
%     set_seed(RT),
%     random(A,B,R),
%     X is R.

quit :-
    halt.

startGame :-
    mainMenu,
    nl,
    read(Command),
    ((
        Command = start,
        start
    );
    (
        Command = help,
        help
    );
    (
        Command = quit,
        quit
    )
    ).

start :-
    reset,
    setState(free),
    write('Welcome to Harvest Star. Choose your job\n'),
    write('1. Fisherman.\n'),
    write('2. Farmer\n'),
    write('3. Rancher\n'),
    read(Job),
    ((
        Job = 1,
        setJob(fisherman)
    );
    (
        Job = 2,
        setJob(farmer)
    );
    (
        Job = 3,
        setJob(rancher)
    )
    ).

