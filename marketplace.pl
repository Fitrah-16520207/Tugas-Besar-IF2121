:- dynamic(inventoryMarket/1).
inventoryMarket([
    % [nama item, harga]
    [potato_seed,40],
    [tomato_seed,50],
    [chicken,200],
    [shovel,300],
    [bait,5],
    [normal_rod,500],
    [good_rod,2000],
    [fertilizer,20],
    [good_fertilizer,40]
]).

:- dynamic(lockedInventoryMarket/1).
lockedInventoryMarket([
    [carrot_seed,60, 3, farming],
    [rice_seed,70, 7, farming],
    [sheep,3000, 3, ranching],
    [cow,4000, 7, ranching],
    [rare_rod,4000, 3, fishing],
    [legend_rod,10000, 7, fishing],
    [best_fertilizer,70, 3, farming],
    [instant_fertilizer,100, 7, farming],
    [potionBreedSheep,2000, 3, ranching],
    [potionBreedCow,2000, 7, ranching]
]).

priceList([
    [potato_seed,40],
    [tomato_seed,50],
    [carrot_seed,60],
    [rice_seed,70],
    [potato,80],
    [tomato,100],
    [carrot,120],
    [rice,150],
    [chicken,200],
    [sheep,3000],
    [cow,4000],
    [egg,50],
    [milk,150],
    [wol,200],
    [lele,30],
    [nila,50],
    [gurame,80],
    [patin,80],
    [salmon,175],
    [tuna,200],
    [pari,1000],
    [barracuda,7500],
    [hiu,10000],
    [bait,5],
    [normal_rod,500],
    [good_rod,2000],
    [rare_rod,4000],
    [legend_rod,10000],
    [shovel,300],
    [fertilizer,20],
    [good_fertilizer,40],
    [best_fertilizer,70],
    [instant_fertilizer,100],
    [potionBreedSheep, 2000],
    [potionBreedCow, 2000]
]).

addItemMarket(Item) :-
    inventoryMarket(Invent),
    itemPrice(Item, Harga),
    append(Invent, [[Item, Harga]], NewInvent),
    retract(inventoryMarket(Invent)),
    assertz(inventoryMarket(NewInvent)).

deletelockedItemMarket(Item) :-
    lockedInventoryMarket(Invent),
    itemPrice(Item, Harga),
    unlockedLvl(Item, Lvl),
    item(Item, Type),
    delete(Invent, [Item, Harga, Lvl, Type], NewInvent),
    retract(lockedInventoryMarket(Invent)),
    assertz(lockedInventoryMarket(NewInvent)).

unlockedItem(Item) :-
    addItemMarket(Item),
    deletelockedItemMarket(Item).

printInventoryMarket([], Number) :-
    lockedInventoryMarket(LIM),
    printLockedInventoryMarket(LIM, Number).
printInventoryMarket([[Nama, Harga]|T], Number) :-
    format('~w. ', [Number]),
    write(Nama), tab(1), format('(~w Gold)', [Harga]),
    IncNumber is Number + 1,
    nl, printInventoryMarket(T, IncNumber).

printLockedInventoryMarket([], _) :- !.
printLockedInventoryMarket([[Nama, Harga, Lvl, Type]|T], Number) :-
    format('~w. ', [Number]),
    write(Nama), tab(1), format('(~w Gold)', [Harga]), tab(3), format('Unlock Item Lvl ~w ', [Lvl]), write(Type),
    IncNumber is Number + 1,
    nl, printLockedInventoryMarket(T, IncNumber).

printPriceList([], _Number) :- !.
printPriceList([[Nama, Harga]|T], Number) :-
    format('~w. ', [Number]),
    write(Nama), tab(1),
    (
        (
            buyable(Nama),
            HargaBuyable is Harga // 2,
            format('(~w Gold)', [HargaBuyable])
        );
        (
            format('(~w Gold)', [Harga])
        )
    ),
    IncNumber is Number + 1,
    nl, printPriceList(T, IncNumber).

itemNth(1, [[Nama, _Harga]|_T], Nama).
itemNth(N, [[_Nama, _Harga]|T], Item) :-
    N > 1,
    DecrN is N - 1,
    itemNth(DecrN, T, Item).

marketplace :-
    state(not_started), !,
    write('Command tidak dikenali karena kamu belum memulai permainan').

marketplace :-
    state(free),
    playerCell(X),
    X \= 'M', !,
    write('Kamu harus berada di marketplace terlebih dahulu').

marketplace :-
    state(market),
    playerCell('M'), !,
    write('Kamu sudah berada di dalam pasar').

marketplace :-
    state(free),
    playerCell('M'),
    setState(market), !,
    gold(UangYangAda),
    write('Selamat datang di pasar sobat miskino\n'),
    format('Kamu punya uang segini : ~w\n', [UangYangAda]),
    write('Apa yang ingin kamu lakukan?\n'),
    write('- buy\n'),
    write('- sell\n'),
    write('- exitMarket\n').

buy :-
    state(not_started),!,
    write('Permainan belum dimulai').

buy :-
    state(free),
    playerCell(X),
    X \= 'M', !,
    write('Kamu harus berada di marketplace terlebih dahulu').

buy :-
    state(free),
    playerCell('M'), !,
    write('Kamu harus masuk dulu ke dalam marketplace').

buy :-
    state(market),
    write('Apa yang ingin kamu beli?\n'),
    inventoryMarket(InventMart),
    printInventoryMarket(InventMart, 1),
    write('Masukan berupa angka : '), read(N),
    length(InventMart, Len),
    (
        (
            N < Len + 1,
            N > 0,
            itemNth(N, InventMart, Item),
            write('Jumlah item yang ingin dibeli : '), read(Qty), nl,
            gold(UangYangAda),
            itemPrice(Item, Harga),
            TotalBayar is Harga * Qty,
            format('Kamu akan membeli ~w ', [Item]), format('sebanyak ~w.\n', [Qty]),
            format('Total pembayaran adalah : ~w Gold\n', [TotalBayar]),
            write('Pastikan kapasitas inventorymu masih cukup\n'),
            write('Lanjut pembayaran (Y/N) : '), read(Input), nl,
            (
                (
                    Input = 'Y',
                    (
                        (
                            UangYangAda < TotalBayar, !, nl,
                            format('Kamu masih miskin untuk membeli ~w sebanyak ini\n', [Item]),
                            write('Transaksi dibatalkan')
                        );
                        (
                            (
                                (
                                    inventory(Invent),
                                    jumlahItem(Invent, IC),
                                    SisaKapasitas is 100 - IC,
                                    SisaKapasitas < Qty, !,
                                    write('Sisa Kapasitasmu tidak cukup untuk menampung item sebanyak itu\n'),
                                    write('Transaksi dibatalkan\n')
                                );
                                (
                                    NewGold is UangYangAda - TotalBayar,
                                    retractall(gold(_)),
                                    asserta(gold(NewGold)), nl,
                                    write('Transaksi berhasil\n'),
                                    addItem(Item, Qty),
                                    checkBuyRanch
                                )
                            )
                        )
                    )
                );
                (
                    Input \= 'Y',
                    write('Transaksi dibatalkan')
                )
            )
        );
        (
            write('Kami tidak menjualnya untuk saat ini')
        )
    ),
    nl.

sell :-
    state(not_started),!,
    write('Permainan belum dimulai').

sell :-
    state(free),
    playerCell(X),
    X \= 'M', !,
    write('Kamu harus berada di marketplace terlebih dahulu').

sell :-
    state(free),
    playerCell('M'), !,
    write('Kamu harus masuk dulu ke dalam marketplace').

sell :-
    state(market),
    write('Berikut daftar harga jual item\n'),
    priceList(PL),
    printPriceList(PL, 1),
    write('Ini adalah daftar item yang ada di item kamu\n'),
    inventory,
    write('Apa item yang ingin kamu jual? :'), tab(2),
    read(Item),
    (
        inventory(Invent),
        (
            % Item tidak ada di dalam inventory
            \+ member([Item, _JumlahItem], Invent), !,
            write('Kami tidak dapat membeli barang tersebut karena tidak ada di inventory kamu\n')
        );
        (
            % item ada di inventory
            write('Jumlah item yang ingin dijual :'), tab(2),
            read(Qty), nl,
            jumlahBarang(Item, C),
            (
                (
                    % jumlah masukan lebih besar daripada jumlah di inventory
                    C < Qty, !,
                    format('Kamu tidak memiliki ~w sebanyak itu\n', [Item])
                );
                (
                    itemPrice(Item, Harga),
                    (
                        (
                            buyable(Item),
                            SellValue is Qty * (Harga // 2)
                        );
                        SellValue is Qty * Harga
                    ),
                    format('Kamu menjual ~w', [Qty]),
                    format(' ~w\n', [Item]),
                    format('Kamu memperoleh ~w Gold\n', [SellValue]),
                    earnGold(SellValue),
                    drop(Item, Qty)
                )
            )
        )
    ).

exitMarket :-
    state(not_started),!,
    write('Permainan belum dimulai').

exitMarket :-
    state(free),
    playerCell(X),
    X \= 'M', !,
    write('Kamu harus berada di marketplace terlebih dahulu').

exitMarket :-
    state(free),
    playerCell('M'), !,
    write('Kamu sudah ada di luar marketplace').

exitMarket :-
    setState(free), !,
    write('Terima kasih telah berkunjung ke pasar\n').