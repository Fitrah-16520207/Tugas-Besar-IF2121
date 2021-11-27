:- dynamic(dapet_ikan/1).
dapet_ikan(belum).

set_dapet_ikan(X) :-
    retractall(dapet_ikan(_)),
    asserta(dapet_ikan(X)).

fish(0):-
    write('Anda tidak punya umpan untuk memancing'),!.
fish(_) :-
    state(not_started), !,
    write('Command tidak dikenali karena kamu belum memulai permainan').
fish(J):-
    state(free),
    J>0,
    playerPoint(R, C),
    NewR is R + 1,waterTilePoint(NewR, C),
    write('You have : \n'),
    write('normal fishing rod\n'),
    write('good fishing rod\n'),
    write('rare fishing rod\n'),
    write('legend fishing rod\n'),
    write('Choose fishing rod\n'),
    read(X),
    fishing(X).
fish(J):-
    state(free),
    J>0,
    playerPoint(R, C),
    NewR is R - 1,waterTilePoint(NewR, C),
    write('You have : \n'),
    write('normal fishing rod\n'),
    write('good fishing rod\n'),
    write('rare fishing rod\n'),
    write('legend fishing rod\n'),
    write('Choose fishing rod\n'),
    read(X),
    fishing(X).
fish(J):-
    state(free),
    J>0,
    playerPoint(R, C),
    NewC is C + 1,waterTilePoint(R, NewC),
    write('You have : \n'),
    write('normal fishing rod\n'),
    write('good fishing rod\n'),
    write('rare fishing rod\n'),
    write('legend fishing rod\n'),
    write('Choose fishing rod\n'),
    read(X),
    fishing(X).
fish(J):-
    state(free),
    J>0,
    playerPoint(R, C),
    NewC is C - 1,waterTilePoint(R, NewC),
    write('You have : \n'),
    write('normal fishing rod\n'),
    write('good fishing rod\n'),
    write('rare fishing rod\n'),
    write('legend fishing rod\n'),
    write('Choose fishing rod\n'),
    read(X),
    fishing(X).
fish(_):-
    write('Kamu tidak berada di sekitar danau').
fishing(legend) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(hiu,LvlFish).
fishing(legend) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(barracuda,LvlFish).
fishing(rare) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(tuna,LvlFish).
fishing(rare) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(salmon,LvlFish).
fishing(good) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(tuna,LvlFish).
fishing(good) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(salmon,LvlFish).
fishing(normal) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(tuna,LvlFish).
fishing(normal) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(salmon,LvlFish).
fishing(good) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(patin,LvlFish).
fishing(good) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(gurame,LvlFish).
fishing(normal) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(patin,LvlFish).
fishing(normal) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(gurame,LvlFish).
fishing(_) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(nila,LvlFish).
fishing(_) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(lele,LvlFish).
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

