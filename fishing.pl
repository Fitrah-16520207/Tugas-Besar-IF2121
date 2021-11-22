:- dynamic(chance)


fish :-
    random_fish(tuna,Lvl),
    random_fish(nila,Lvl),
    random_fish(lele,Lvl),
    random_fish(gurame,Lvl),
    random_fish(patin,Lvl),
    random_fish(barracuda,Lvl),
    random_fish(hiu,Lvl).

chance_item(tuna,5).
chance_item(nila,30).
chance_item(lele,50).
chance_item(gurame,10).
chance_item(patin,10).
chance_item(barracuda,1).
canche_item(hiu,1).

random_fish(X,Lv) :-
    chance_item(X,C),
    Chance is C + Lv,
    acak(0,Chance,R),
    R <= Chance,
    write('Dapat ikan').

