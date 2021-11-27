%mengimpor map
:- include('map.pl').
:- include('inventory.pl').

%deklarasi farming
:- dynamic(farming/1).

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
    playerCell(C),
    C = ('-'),
    playerPoint(X,Y),
    asserta(diggedTilePoint(X, Y)),
    write('lokasi berhasil digali').

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
        drop('carrot_seed')
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
        drop('potato_seed')
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
        drop('tomato_seed')
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
        drop('rice_seed')
    ;
        write('Anda tidak memiliki rice_seed')
    ).

harvest :-
    state(free),
    playerCell(C),
    ((
        C = ('c'),
        addItem('carrot',3),
        write('carrot berhasil dipanen'),
        playerPoint(X,Y),
        retract(carrotTilePoint(X,Y))
    );
    (   
        C = ('p'),
        addItem('potato',3),
        write('potato berhasil dipanen'),
        playerPoint(X,Y),
        retract(potatoTilePoint(X,Y))
    );
    (
        C = ('t'),
        addItem('tomato',3),
        write('tomato berhasil dipanen'),
        playerPoint(X,Y),
        retract(tomatoTilePoint(X,Y))
    );
    (
        C = ('r'),
        addItem('rice', 5),
        write('rice berhasil dipanen'),
        playerPoint(X,Y),
        retract(riceTilePoint(X,Y))
    );
        write('Tidak ada tanaman yang dipanen')
    ).