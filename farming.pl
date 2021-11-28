%deklarasi farming
:- dynamic(farming/1).
:- dynamic(panen/3).


%untuk prosedure dig
%mengecek apakah tanah bisa digali atau tidak
dig :-
    state(not_started),!,
    write('Permainan belum dimulai').

dig :-
    state(free),
    playerCell(X),
    X \= ('-'), !,
    write('Kamu berada di lokasi yang tidak bisa digali').

dig :-
    state(free),
    inventory(Invent),
    playerCell(C),
    C = ('-'),
    (member(['shovel',_], Invent) ->
        playerPoint(X,Y),
        asserta(diggedTilePoint(X, Y)),
        write('lokasi berhasil digali')
    ;
        write('Anda harus punya shovel untuk mengggali')
    ).


%untuk prosedure plant 
plant :-
    state(not_started),!,
    write('Permainan belum dimulai').

plant :-
    state(free),
    playerCell(X),
    X \= ('='), !,
    write('Kamu tidak bisa menanam tumbuhan di lokasi ini').

plant :-
    state(free),
    playerCell(C),
    C = ('='),
    write('seed yang anda miliki :'),nl,
    printTanaman('carrot'),
    printTanaman('potato'),
    printTanaman('tomato'),
    printTanaman('rice'),
    write('Tanaman apa yang akan anda tanam:'),nl,

    read(Tanam),
    ((
        Tanam = 'carrot',
        cekJumlah('carrot')
    );
    (
        Tanam = 'potato',
        cekJumlah('potato')
    );
    (
        Tanam = 'tomato',
        cekJumlah('tomato')
    );
    (
        Tanam = 'rice',
        cekJumlah('rice')
    );
        write('input salah'),nl,
        write('ketikkan "carrot." untuk menanam carrot'),nl,
        write('ketikkan "potato." untuk menanam potato'),nl,
        write('ketikkan "tomato." untuk menanam tomato'),nl,
        write('ketikkan "rice." untuk menanam rice'),nl,
        write('untuk mengecek seed yang dimiliki gunakan command "inventory."')
    ).

cekJumlah('carrot'):-
    inventory(Invent),
    (member(['carrot_seed', _], Invent) ->
        playerPoint(X, Y),
        retract(diggedTilePoint(X,Y)),
        asserta(carrotTilePoint(X,Y)),
        write('carrot berhasil ditanam'),
        drop('carrot_seed'),
        days(A),
        MasaPanen is A + 3,
        asserta(panen(X,Y,MasaPanen))
    ;
        write('Anda tidak memiliki carrot_seed')
    ).

cekJumlah('potato'):-
    inventory(Invent),
    (member(['potato_seed', _], Invent) ->
        playerPoint(X, Y),
        retract(diggedTilePoint(X,Y)),
        asserta(potatoTilePoint(X,Y)),
        write('potato berhasil ditanam'),
        drop('potato_seed'),
        days(A),
        MasaPanen is A + 2,
        asserta(panen(X,Y,MasaPanen))
    ;
        write('Anda tidak memiliki potato_seed')
    ).

cekJumlah('tomato'):-
    inventory(Invent),
    (member(['tomato_seed', _], Invent) ->
        playerPoint(X, Y),
        retract(diggedTilePoint(X,Y)),
        asserta(tomatoTilePoint(X,Y)),
        write('tomato berhasil ditanam'),
        drop('tomato_seed'),
        days(A),
        MasaPanen is A + 3,
        asserta(panen(X,Y,MasaPanen))
    ;
        write('Anda tidak memiliki tomato_seed')
    ).

cekJumlah('rice'):-
    inventory(Invent),
    (member(['rice_seed', _], Invent) ->
        playerPoint(X, Y),
        retract(diggedTilePoint(X,Y)),
        asserta(riceTilePoint(X,Y)),
        write('rice berhasil ditanam'),
        drop('rice_seed'),
        days(A),
        MasaPanen is A + 4,
        asserta(panen(X,Y,MasaPanen))
    ;
        write('Anda tidak memiliki rice_seed')
    ).

printTanaman('carrot') :-
    inventory(Invent),
    (member(['carrot_seed', JumlahT], Invent) ->
        write(JumlahT), write(' '), write('carrot'),nl
    ;
        write('')
    ).

printTanaman('potato') :-
    inventory(Invent),
    (member(['potato_seed', JumlahT], Invent) ->
        write(JumlahT), write(' '), write('potato'),nl
    ;
        write('')
    ).

printTanaman('tomato') :-
    inventory(Invent),
    (member(['tomato_seed', JumlahT], Invent) ->
        write(JumlahT), write(' '), write('tomato'),nl
    ;
        write('')
    ).

printTanaman('rice') :-
    inventory(Invent),
    (member(['rice_seed', JumlahT], Invent) ->
        write(JumlahT), write(' '), write('rice'),nl
    ;
        write('')
    ).



%untuk prosedur harvest
harvest :-
    state(free),
    inventory(Invent),
    jumlahItem(Invent, IC),
    playerCell(C),
    ((
        C = ('c'),
        days(D),
        playerPoint(X,Y),
        panen(X,Y,A),
        (A =< D ->
            (IC + 3 =< 100 ->
                addItem('carrot',3),
                write('carrot berhasil dipanen'),
                retract(carrotTilePoint(X,Y)),!
            ;
                write('inventory penuh, item tidak bisa dipanen'),!
            )
        ;
            write('Tanaman belum siap panen'),!
        )
    );
    (   
        C = ('p'),
        days(D),
        playerPoint(X,Y),
        panen(X,Y,A),
        (A =< D ->
            (IC + 3 =< 100 ->
                addItem('potato',3),
                write('potato berhasil dipanen'),
                retract(potatoTilePoint(X,Y)),!
            ;
                write('inventory penuh, item tidak bisa dipanen'),!
            )
        ;
            write('Tanaman belum siap panen'),!
        )
    );
    (
        C = ('t'),
        days(D),
        playerPoint(X,Y),
        panen(X,Y,A),
        (A =< D ->
            (IC + 3 =< 100 ->
                addItem('tomato',3),
                write('tomato berhasil dipanen'),
                retract(tomatoTilePoint(X,Y)),!
            ;
                write('inventory penuh, item tidak bisa dipanen'),!
            )
        ;
            write('Tanaman belum siap panen'),!
        )
    );
    (
        C = ('r'),
        days(D),
        playerPoint(X,Y),
        panen(X,Y,A),
        (A =< D ->
            (IC + 5 =< 100 ->
                addItem('rice', 5),
                write('rice berhasil dipanen'),
                retract(riceTilePoint(X,Y)),!
            ;
                write('inventory penuh, item tidak bisa dipanen'),!
            )
        ;
            write('Tanaman belum siap panen'),!
        )
    );
        (
            write('Tidak ada tanaman yang dipanen'),!
        )
    ).