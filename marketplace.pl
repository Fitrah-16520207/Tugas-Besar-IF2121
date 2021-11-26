:- dynamic(stateMarket/1).
% dapat berupa
% 'di dalam' : ketika di market tapi belum nulis command marketplace.
% 'di luar' : ketika telah keluar dari market (exitMarket)
stateMarket('di luar').

marketplace :-
    state(not_started), !,
    write('Command tidak dikenali karena kamu belum memulai permainan').

marketplace :-
    state(free),
    playerCell(X),
    X \= 'M', !,
    write('Kamu harus berada di marketplace terlebih dahulu').

marketplace :-
    state(free),
    playerCell('M'),
    stateMarket('di dalam'), !,
    write('Kamu sudah berada di dalam pasar sayang').

marketplace :-
    state(free),
    playerCell('M'),
    stateMarket('di luar'), !,
    retractall(stateMarket(_)),
    asserta(stateMarket('di dalam')),
    gold(UangYangAda),
    write('Selamat datang di pasar sobat miskino\n'),
    format('Kamu punya uang segini : ~w\n', [UangYangAda]).

exitMarket :-
    write('Terima kasih telah berkunjung ke pasar\n'),
    retractall(stateMarket(_)),
    asserta(stateMarket('di luar')).