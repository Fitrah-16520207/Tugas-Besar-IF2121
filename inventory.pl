/*deklarasi inventory*/
:- dynamic(inventory/1).


/*mengeprint inventory*/
inventory :- 
    inventory(Invent), 
    jumlahItem(Invent, IC),
    write('Inventory kamu ('),write(IC),write('/100)'),nl, 
    printInventory(Invent).

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
    \+inventory(_), !,
    asserta(inventory([[Item, Jumlah]])).
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
        write('Tidak bisa menambahkan barang, inventory penuh')
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
            write('Jumlah item yang dibuang melebihi jumlah item yang dimiliki')
        )
    ;
        write('Kamu tidak memiliki item tersebut di inventory kamu')
    ).

/*menambahkan command throwItem*/
throwItem :-
    inventory(Invent),
    write('Isi inventory kamu: '),
    nl,inventory,
    write('Apa yang ingin kamu buang: '),
    nl,read(Item),
    nl,write('Masukkan jumlah item yang ingin kamu buang: '),
    nl,read(Jumlah),
    (member([Item,JumlahInv], Invent) ->
        (Jumlah =< JumlahInv -> 
            drop(Item, Jumlah),
            write('Item berhasil dibuang')
        ;
            write('Jumlah item yang dibuang melebihi jumlah item yang dimiliki')
        )
    ;
        write('Item tidak ada di inventory')
    ).

%menambahkan command cekBarang untuk memeriksa apakah barang ada atau tidak
cekBarang(Namaitem) :- 
    inventory(Invent),
    (member([Namaitem,_], Invent) ->
        write('Barang ada di inventory')
    ;
        write('Barang tidak ada di inventory')
    ).

%rule untuk mengetahui jumlah barang
jumlahBarang(Namabarang, C) :-
    inventory(Invent),
    (member([Namabarang, JumlahInv], Invent) ->
        C is JumlahInv
    ).
