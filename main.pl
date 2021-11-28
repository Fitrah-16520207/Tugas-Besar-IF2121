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
:- include('house.pl').

:- dynamic(state/1).
state(not_started).

% State dapat berupa:
% * not_started
% * free
% * market
% * house
% * quest
% * finished

setState(X) :-
    retractall(state(_)),
    asserta(state(X)).

acak(A,B,X) :-
    real_time(RT),
    set_seed(RT),
    random(A,B,R),
    X is R.

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
    );
    (
        write('Command tidak dikenali karena kamu belum memulai game.\nSilakan start untuk memulai game')
    )
    ).

start :-
    reset,
    state(not_started),
    setState(free),
    write('Selamat Datand di Harvest Star. Pilih pekerjaanmu\n'),
    write('1. Fisherman.\n'),
    write('     Kamu akan menjadi pemancing handal yang dibekali dengan'),nl,
    write('         1. Satu buah pancingan biasa\n'),
    write('         2. Delapan buah umpan\n'),
    write('2. Farmer\n'),
    write('     Kamu akan menjadi petani terampil yang dibekali dengan\n'),
    write('         1. Satu buah sekop\n'),
    write('         2. Tiga benih potato\n'),
    write('3. Rancher\n'),
    write('     Kamu akan menjadi peternak tekun yang dibekali dengan\n'),
    write('         1. Dua ekor ayam\n'),
    write('Input berupa nomor.\n'),
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
    ),
    mainMenu,
    baseStats.

