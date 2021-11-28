:- dynamic(dapet_ikan/1).
dapet_ikan(belum).

set_dapet_ikan(X) :-
    retractall(dapet_ikan(_)),
    asserta(dapet_ikan(X)).

fish:-
    playerPoint(R, C),
    NewR is R + 1,waterTilePoint(NewR, C),
    state(free),
    jumlahBarang(bait,X),
    X>0,
    drop(bait),
    mancing.
fish:-
    playerPoint(R, C),
    NewR is R - 1,waterTilePoint(NewR, C),
    state(free),
    jumlahBarang(bait,X),
    X>0,
    drop(bait),
    mancing.
fish:-
    playerPoint(R, C),
    NewC is C + 1,waterTilePoint(R, NewC),
    state(free),
    jumlahBarang(bait,X),
    X>0,
    drop(bait),
    mancing.
fish:-
    playerPoint(R, C),
    NewC is C - 1,waterTilePoint(R, NewC),
    state(free),
    jumlahBarang(bait,X),
    X>0,
    drop(bait),
    mancing.
fish:-
    jumlahBarang(bait,X),
    X>0,
    write('Kamu tidak berada di sekitar danau'),!.
fish:-
    state(free),
    cekBarang(bait),nl,
    write('Anda tidak punya umpan untuk memancing'),!.
fish:-
    state(not_started), !,
    write('Command tidak dikenali karena kamu belum memulai permainan').
mancing:-
    write('Pancingan yang kamu punya: \n'),
    printRod(good_rod),
    printRod(normal_rod),
    printRod(rare_rod),
    printRod(legend_rod),
    pancingan.

printRod(X) :-
    inventory(Invent),
    (member([X, _], Invent) ->
        write(' '), write(X),nl
    ;
        write('')
    ).
pancingan:-
    write('Pilih pancingan yang akan kamu gunakan dengan mengetik nama pancingan'),nl,
    read(X),
    jumlahBarang(X,Y),
    Y>0,
    fishing(X).
pancingan:-
    write('Pilih pancingan yang akan kamu gunakan dengan mengetik nama pancingan'),ml,
    read(X),
    cekBarang(X),nl,
    write('Kamu tidak mempunyai pancingan ini').

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
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    addItem(X,1),
    set_dapet_ikan(udah),
    fail.

