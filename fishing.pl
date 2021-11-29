:- dynamic(dapet_ikan/1).
dapet_ikan(belum).

set_dapet_ikan(X) :-
    retractall(dapet_ikan(_)),
    asserta(dapet_ikan(X)).

fish:-
    playerCell(C),
    C = ('o'),
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
    write('Kamu tidak punya umpan untuk memancing'),!.
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

fishing(legend_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(hiu,LvlFish,legend_rod).
fishing(legend_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(barracuda,LvlFish,legend_rod).
fishing(legend_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(tuna,LvlFish,legend_rod).
fishing(legend_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(salmon,LvlFish,legend_rod).
fishing(legend_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(pari,LvlFish,legend_rod).
fishing(legend_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(gurame,LvlFish,legend_rod).
fishing(legend_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(patin,LvlFish,legend_rod).
fishing(legend_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(nila,LvlFish,legend_rod).
fishing(legend_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(lele,LvlFish,legend_rod).
fishing(rare_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(tuna,LvlFish,rare_rod).
fishing(rare_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(salmon,LvlFish,rare_rod).
fishing(rare_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(pari,LvlFish,rare_rod).
fishing(rare_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(gurame,LvlFish,rare_rod).
fishing(rare_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(patin,LvlFish,rare_rod).
fishing(rare_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(nila,LvlFish,rare_rod).
fishing(rare_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(lele,LvlFish,rare_rod).
fishing(good_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(patin,LvlFish,good_rod).
fishing(good_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(gurame,LvlFish,good_rod).
fishing(good_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(nila,LvlFish,good_rod).
fishing(good_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(lele,LvlFish,good_rod).
fishing(normal_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(nila,LvlFish,normal_rod).
fishing(normal_rod) :- levelFishing(LvlFish),dapet_ikan(belum),random_fish(lele,LvlFish,normal_rod).
fishing(_) :- dapet_ikan(belum),levelFishing(LvlFish),write('Tidak dapat ikan\n'),Exp is 5*LvlFish,earnFishingExp(Exp),write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n').
fishing(_) :- set_dapet_ikan(belum).

chance_item(tuna,6).
chance_item(salmon,8).
chance_item(nila,30).
chance_item(lele,50).
chance_item(gurame,10).
chance_item(patin,10).
chance_item(pari,3).
chance_item(barracuda,2).
chance_item(hiu,1).

random_fish(X,Lv,normal_rod) :-
    playerJob(E),
    E = ('fisherman'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),nl,
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 10*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.
random_fish(X,Lv,good_rod) :-
    playerJob(E),
    E = ('fisherman'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 15*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.
random_fish(X,Lv,rare_rod) :-
    playerJob(E),
    E = ('fisherman'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 20*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.
random_fish(X,Lv,legend_rod) :-
    playerJob(E),
    E = ('fisherman'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 25*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.

random_fish(X,Lv,normal_rod) :-
    playerJob(E),
    E = ('farmer'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),nl,
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 8*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.
random_fish(X,Lv,good_rod) :-
    playerJob(E),
    E = ('farmer'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 12*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.
random_fish(X,Lv,rare_rod) :-
    playerJob(E),
    E = ('farmer'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 17*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.
random_fish(X,Lv,legend_rod) :-
    playerJob(E),
    E = ('farmer'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 22*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.

random_fish(X,Lv,normal_rod) :-
    playerJob(E),
    E = ('rancher'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),nl,
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 8*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.
random_fish(X,Lv,good_rod) :-
    playerJob(E),
    E = ('rancher'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 12*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.
random_fish(X,Lv,rare_rod) :-
    playerJob(E),
    E = ('rancher'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 17*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.
random_fish(X,Lv,legend_rod) :-
    playerJob(E),
    E = ('rancher'),
    chance_item(X,C),
    Chance is C + Lv*5,
    acak(0,100,R),
    R =< Chance,
    write('Dapat ikan '),
    write(X),
    addItem(X,1),
    set_dapet_ikan(udah),
    Exp is 22*Lv,
    write('Mendapat exp fishing sebesar '),write(Exp),write(' Exp \n'),
    earnFishingExp(Exp),
    updateActiveQuest(fish,1),
    fail.
