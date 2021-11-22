/*deklarasi inventory*/
:- dynamic(inventory/1).


/*mengeprint inventory*/
inventory :- inventory(Invent), printInventory(Invent).
printInventory([]) :- !.
printInventory([[Nama, Jumlah]|T]) :-
    write(Jumlah), write(' '), write(Nama),
    nl, printInventory(T).

/*menghiutng jumlah item*/
jumlahItem([], 0).
jumlahItem([[_, Jumlah]|T], Total) :-
    jumlahItem(T, Jumlah1),
    Total is Jumlah + Jumlah1.

     
/* menambahkan item */
addItem(_, Jumlah) :- 
    Jumlah =< 0, !, 
    write('Jumlah item harus lebih dari 0'), 
    fail.
addItem(Item, Jumlah) :-
    item(Item, _),
    inventory(Invent),
    jumlahItem(Invent, IC),
    (Jumlah + IC =< 100 ->
        (member([Item, JumlahInv], Invent) ->
            JumlahBaru is JumlahInv + Jumlah,
            delete(Invent, [Item, JumlahInv], TempInv),
            append(TempInv, [[Item, JumlahBaru]], NewInv),
            retract(inventory(Invent)),
            assertz(inventory(NewInv))
        ;
            append(Invent, [[Item, Jumlah]], NewInv),
            retract(inventory(Invent)),
            assertz(inventory(NewInv))
        )
    ;
        write('tidak bisa menambahkan barang, inventory penuh')
    ).

/* mengurangi item */
drop(Item) :- drop(Item, 1).
drop(_, Jumlah) :- 
    Jumlah =< 0, !,
    write('Jumlah item harus lebih besar dari 0'),
    fail.
drop(Item, Jumlah) :-
    inventory(Invent),
    (member([Item, JumlahInv], Invent) ->
        (JumlahInv > Jumlah ->
            JumlahBaru is JumlahInv - Jumlah,
            delete(Invent, [Item, JumlahInv], TempInv),
            append(TempInv, [[Item, JumlahBaru]], NewInv),
            retract(inventory(Invent)),
            assertz(inventory(NewInv))
        ; JumlahInv =:= Jumlah ->
            delete(Invent, [Item, JumlahInv], NewInv),
            retract(inventory(Invent)),
            assertz(inventory(NewInv))
        ;
            write('jumlah item di inventory adan di kurangi')
        )
    ;
        write('Anda tidak memiliki item tersebut di inventory anda')
    ).