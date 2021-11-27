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
        drop('rice_seed')
    ;
        write('Anda tidak memiliki rice_seed')
    ).

panen :-
    state(free),
    playerCell(X),
    X \= ('p'), !,
    write('Tidak ada tanaman yang dipanen').

panen :-
    state(free),
    playerCell(X),
    X \= ('c'), !,
    write('Tidak ada tanaman yang dipanen').

panen :-
    state(free),
    playerCell(X),
    X \= ('t'), !,
    write('Tidak ada tanaman yang dipanen').

panen :-
    state(free),
    playerCell(X),
    X \= ('r'), !,
    write('Tidak ada tanaman yang dipanen').