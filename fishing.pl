:- dynamic(dapet_ikan/1).
dapet_ikan(belum).

set_dapet_ikan(X) :-
    retractall(dapet_ikan(_)),
    asserta(dapet_ikan(X)).

fish(0):-
    write('Anda tidak punya umpan untuk memancing'),!.

fish(J):-
    J>0,
    write('You have : \n'),
    write('normal fishing rod\n'),
    write('good fishing rod\n'),
    write('rare fishing rod\n'),
    write('legend fishing rod\n'),
    write('Choose fishing rod\n'),
    read(X),
    fishing(X).

fishing(legend) :- dapet_ikan(belum),random_fish(hiu,Lvl).
fishing(legend) :- dapet_ikan(belum),random_fish(barracuda,Lvl).
fishing(rare) :- dapet_ikan(belum),random_fish(tuna,Lvl).
fishing(rare) :- dapet_ikan(belum),random_fish(salmon,Lvl).
fishing(good) :- dapet_ikan(belum),random_fish(patin,Lvl).
fishing(good) :- dapet_ikan(belum),random_fish(gurame,Lvl).
fishing(normal) :- dapet_ikan(belum),random_fish(nila,Lvl).
fishing(normal) :- dapet_ikan(belum),random_fish(lele,Lvl).
fishing(_) :- dapet_ikan(belum),write('Tidak dapat ikan\n').
fishing(_) :- set_dapet_ikan(belum).

chance_item(tuna,5).
chance_item(salmon,8).
chance_item(nila,30).
chance_item(lele,50).
chance_item(gurame,10).
chance_item(patin,10).
chance_item(barracuda,1).
canche_item(hiu,1).

random_fish(X,Lv) :-
    chance_item(X,C),
    Chance is C + Lv,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    set_dapet_ikan(udah),
    fail.

