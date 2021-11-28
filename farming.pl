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
        cellCheck(X,Y),
        write('Lokasi berhasil digali')
    ;
        write('Kamu harus punya shovel untuk mengggali')
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
    write('Seed yang kamu miliki :'),nl,
    printTanaman('carrot'),
    printTanaman('potato'),
    printTanaman('tomato'),
    printTanaman('rice'),
    write('Tanaman apa yang akan kamu tanam:'),nl,

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
        write('Input salah'),nl,
        write('Ketikkan "carrot." untuk menanam carrot'),nl,
        write('Ketikkan "potato." untuk menanam potato'),nl,
        write('Ketikkan "tomato." untuk menanam tomato'),nl,
        write('Ketikkan "rice." untuk menanam rice'),nl,
        write('Untuk mengecek seed yang dimiliki gunakan command "inventory."')
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
        acak(6,7,M),
        MasaPanen is A + M,
        asserta(panen(X,Y,MasaPanen))
    ;
        write('Kamu tidak memiliki carrot_seed')
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
        acak(3,4,M),
        MasaPanen is A + M,
        asserta(panen(X,Y,MasaPanen))
    ;
        write('Kamu tidak memiliki potato_seed')
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
        acak(2,3,M),
        MasaPanen is A + M,
        asserta(panen(X,Y,MasaPanen))
    ;
        write('Kamu tidak memiliki tomato_seed')
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
        acak(2,3,M),
        MasaPanen is A + M,
        asserta(panen(X,Y,MasaPanen))
    ;
        write('Kamu tidak memiliki rice_seed')
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
            acak(2,6,N),
            (IC + N =< 100 ->
                addItem('carrot',N),
                write('carrot berhasil dipanen\n'),
                retract(carrotTilePoint(X,Y)),
                playerJob(E),
                (
                    E = ('farmer'),
                    earnFarmingExp(3),
                    write('kamu mendapatkan 3 exp'),!
                ;
                    earnFarmingExp(2),
                    write('kamu mendapatkan 2 exp'),!
                )
            ;
                write('Inventory penuh, item tidak bisa dipanen\n'),!
            )
        ;
            write('Tanaman belum siap panen'),
            Sisa is A-D,
            write('bisa dipanen dalam : '),write(Sisa),write(' hari'),!
        )
    );
    (   
        C = ('p'),
        days(D),
        playerPoint(X,Y),
        panen(X,Y,A),
        (A =< D ->
            acak(1,4,N),
            (IC + N =< 100 ->
                addItem('potato',N),
                write('potato berhasil dipanen\n'),
                retract(potatoTilePoint(X,Y)),
                playerJob(E),
                (
                    E = ('farmer'),
                    earnFarmingExp(3),
                    write('kamu mendapatkan 3 exp'),!
                ;
                    earnFarmingExp(2),
                    write('kamu mendapatkan 2 exp'),!
                )
            ;
                write('Inventory penuh, item tidak bisa dipanen'),!
            )
        ;
            write('Tanaman belum siap panen\n'),
            Sisa is A-D,
            write('Bisa dipanen dalam : '),write(Sisa),write(' hari'),!
        )
    );
    (
        C = ('t'),
        days(D),
        playerPoint(X,Y),
        panen(X,Y,A),
        (A =< D ->
            acak(1,4,N),
            (IC + N =< 100 ->
                addItem('tomato',N),
                write('tomato berhasil dipanen\n'),
                retract(tomatoTilePoint(X,Y)),
                playerJob(E),
                (
                    E = ('farmer'),
                    earnFarmingExp(3),
                    write('Kamu mendapatkan 3 exp'),!
                ;
                    earnFarmingExp(2),
                    write('Kamu mendapatkan 2 exp'),!
                )
            ;
                write('Inventory penuh, item tidak bisa dipanen\n'),!
            )
        ;
            write('Tanaman belum siap panen'),
            Sisa is A-D,
            write('Bisa dipanen dalam : '),write(Sisa),write(' hari'),!
        )
    );
    (
        C = ('r'),
        days(D),
        playerPoint(X,Y),
        panen(X,Y,A),
        (A =< D ->
            acak(3,6,N),
            (IC + N =< 100 ->
                addItem('rice', N),
                write('rice berhasil dipanen\n'),
                retract(riceTilePoint(X,Y)),
                playerJob(E),
                (
                    E = ('farmer'),
                    earnFarmingExp(3),
                    write('kamu mendapatkan 3 exp'),!
                ;
                    earnFarmingExp(2),
                    write('kamu mendapatkan 2 exp'),!
                )
            ;
                write('Inventory penuh, item tidak bisa dipanen'),!
            )
        ;
            write('Tanaman belum siap panen\n'),
            Sisa is A-D,
            write('Bisa dipanen dalam : '),write(Sisa),write(' hari'),!
        )
    );
        (
            write('Tidak ada tanaman yang dipanen'),!
        )
    ).

usefertilizer :-
    state(free),
    playerCell('p'),
    write('Pupuk yang kamu miliki: \n'),
    printPupuk('fertilizer'),
    printPupuk('good_fertilizer'),
    printPupuk('best_fertilizer'),
    printPupuk('instant_fertilizer'),
    write('Pupuk apa yang kamu gunakan : \n'),
    read(Pupuk),
    (
        (
            Pupuk = ('fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            NewA is A-1,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('fertilizer')
        )
    ;
        (
            Pupuk = ('good_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            Potong is round(A*0.5),
            NewA is A-Potong,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('good_fertilizer')
        )
    ;
        (
            Pupuk = ('best_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            Potong is round(A*0.75),
            NewA is A-Potong,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('best_fertilizer')
        )
    ;
        (
            Pupuk = ('instant_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,1)),
            drop('instant_fertilizer')
        )
    ;
        write('Masukkan pupuk salah')
    ).

usefertilizer :-
    state(free),
    playerCell('c'),
    write('Pupuk yang kamu miliki: \n'),
    printPupuk('fertilizer'),
    printPupuk('good_fertilizer'),
    printPupuk('best_fertilizer'),
    printPupuk('instant_fertilizer'),
    write('Pupuk apa yang kamu gunakan : \n'),
    read(Pupuk),
    (
        (
            Pupuk = ('fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            NewA is A-1,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('fertilizer')
        )
    ;
        (
            Pupuk = ('good_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            Potong is round(A*0.5),
            NewA is A-Potong,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('good_fertilizer')
        )
    ;
        (
            Pupuk = ('best_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            Potong is round(A*0.75),
            NewA is A-Potong,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('best_fertilizer')
        )
    ;
        (
            Pupuk = ('instant_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,1)),
            drop('instant_fertilizer')
        )
    ;
        write('Masukkan pupuk salah')
    ).

usefertilizer :-
    state(free),
    playerCell('t'),
    write('Pupuk yang kamu miliki: \n'),
    printPupuk('fertilizer'),
    printPupuk('good_fertilizer'),
    printPupuk('best_fertilizer'),
    printPupuk('instant_fertilizer'),
    write('Pupuk apa yang kamu gunakan : \n'),
    read(Pupuk),
    (
        (
            Pupuk = ('fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            NewA is A-1,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('fertilizer')
        )
    ;
        (
            Pupuk = ('good_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            Potong is round(A*0.5),
            NewA is A-Potong,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('good_fertilizer')
        )
    ;
        (
            Pupuk = ('best_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            Potong is round(A*0.75),
            NewA is A-Potong,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('best_fertilizer')
        )
    ;
        (
            Pupuk = ('instant_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,1)),
            drop('instant_fertilizer')
        )
    ;
        write('Masukkan pupuk salah')
    ).

usefertilizer :-
    state(free),
    playerCell('r'),
    write('Pupuk yang kamu miliki: \n'),
    printPupuk('fertilizer'),
    printPupuk('good_fertilizer'),
    printPupuk('best_fertilizer'),
    printPupuk('instant_fertilizer'),
    write('Pupuk apa yang kamu gunakan : \n'),
    read(Pupuk),
    (
        (
            Pupuk = ('fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            NewA is A-1,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('fertilizer')
        )
    ;
        (
            Pupuk = ('good_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            Potong is round(A*0.5),
            NewA is A-Potong,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('good_fertilizer')
        )
    ;
        (
            Pupuk = ('best_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            Potong is round(A*0.75),
            NewA is A-Potong,
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,NewA)),
            drop('best_fertilizer')
        )
    ;
        (
            Pupuk = ('instant_fertilizer'),
            playerPoint(X,Y),
            panen(X,Y,A),
            retract(panen(X,Y,A)),
            asserta(panen(X,Y,1)),
            drop('instant_fertilizer')
        )
    ;
        write('Masukkan pupuk salah')
    ).

printPupuk('fertilizer') :-
    inventory(Invent),
    (member(['fertilizer', JumlahT], Invent) ->
        write(JumlahT), write(' '), write('fertilizer'),nl
    ;
        write('')
    ).

printPupuk('good_fertilizer') :-
    inventory(Invent),
    (member(['good_fertilizer', JumlahT], Invent) ->
        write(JumlahT), write(' '), write('good_fertilizer'),nl
    ;
        write('')
    ).

printPupuk('best_fertilizer') :-
    inventory(Invent),
    (member(['best_fertilizer', JumlahT], Invent) ->
        write(JumlahT), write(' '), write('best_fertilizer'),nl
    ;
        write('')
    ).

printPupuk('instant_fertilizer') :-
    inventory(Invent),
    (member(['instant_fertilizer', JumlahT], Invent) ->
        write(JumlahT), write(' '), write('instant_fertilizer'),nl
    ;
        write('')
    ).