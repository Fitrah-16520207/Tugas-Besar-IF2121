:- dynamic(chance)


fish :-
    random_fish(tuna,Lv),
    random_fish(nila,Lv),
    random_fish(lele,Lv),
    random_fish(gurame,Lv),
    random_fish(patin,Lv),
    random_fish(barracuda,Lv),
    random_fish(hiu,Lv).

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

