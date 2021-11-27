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
    format('Kamu punya uang segini : ~w\n', [UangYangAda]),
    write('Apa yang ingin kamu lakukan?\n'),
    write('- buy\n'),
    write('- sell\n').

buy :-
    state(free),
    stateMarket('di dalam'),
    write('Apa yang ingin kamu beli?\n'),
    buyable(X),
    write(X), nl.

sell :-
    state(free),
    stateMarket('di dalam'),
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
                    earnGold(SellValue),
                    format('Kamu menjual ~w', [Qty]),
                    format(' ~w\n', [Item]),
                    format('Kamu memperoleh ~w Gold\n', [SellValue]),
                    drop(Item, Qty)
                )
            )
        )
    ).

exitMarket :-
    stateMarket('di dalam'),
    write('Terima kasih telah berkunjung ke pasar\n'),
    retractall(stateMarket(_)),
    asserta(stateMarket('di luar')).