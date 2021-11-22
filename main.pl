:- include('inventory.pl').
:- include('map.pl').
:- include('item.pl').
:- include('menu.pl').
:- include('pemain.pl').

:- dynamic(state/1).




state(not_started).

setState(X) :-
    retractall(state(_)),
    asserta(state(X)).

acak(A,B,X) :-
    real_time(RT),
    set_seed(RT),
    random(A,B,R),
    X is R.



startGame :-
    mainMenu,
    nl,
    read(Command),
    ((
        Command = start,
        start
    );
    (
        Command = map,
        map
    );
    (
        Command = status,
        status
    );
    (
        Command = help,
        help
    );
    (
        Command = quit,
        quit
    )
    )

start :-
    reset,
    setState(free)
    write('Welcome to Harvest Star. Choose your job'),
    read(Job),
    setJob(Job).


quit :-
    halt.


