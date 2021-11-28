:- dynamic(chicken/2).
:- dynamic(chicks/2).
:- dynamic(cow/2).
:- dynamic(calf/2).
:- dynamic(sheep/2).
:- dynamic(lamb/2).
:- dynamic(incubation/1).
:- dynamic(pregnantCow/2).
:- dynamic(pregnantSheep/2).

count(P,Count) :-
    findall(1,P,L),
    length(L,Count).

lihatHewanTernak :-
    count(chicken(_, _), CountChicken),
    count(chicks(_, _), CountChicks),
    count(cow(_, _), CountCow),
    count(calf(_, _), CountCalf),
    count(sheep(_, _), CountSheep),
    count(lamb(_, _), CountLamb),
    write('Anda memiliki:'), nl,
    format('~d ayam', [CountChicken]), nl,
    format('~d anak ayam', [CountChicks]), nl,
    format('~d sapi', [CountCow]), nl,
    format('~d anak sapi', [CountCalf]), nl,
    format('~d domba', [CountSheep]), nl,
    format('~d anak domba', [CountLamb]), nl.


ambilHasil :- 
    write(' Pilih hewan yang ingin diambil hasil ternaknya'), nl,
    write(' 1. Ayam'), nl,
    write(' 2. Sapi'), nl,
    write(' 3. Domba'), nl, nl,
    read(InputAmbilHasil),
    (
        InputAmbilHasil = 1, !,
        ranchChicken
    );
    (
        InputAmbilHasil = 2, !,
        ranchCow
    );
    (
        InputAmbilHasil = 3, !,
        ranchSheep
    ).

ranchChicken :-
    count(chicken(_, 0), Count),
    forall(chicken(Name, Days),
        (
            (
                Days = 0,
                addItem(egg, 1),
                NewDays is 3,
                retract(chicken(Name, Days)),
                assertz(chicken(Name, NewDays))
            );
            (
                Days > 0    
            )
        )
    ),
    (
        (
            Count > 0,
            format('Kamu mendapatkan ~d telur\n',[Count]),
            Exp is Count * 3,
            earnRanchingExp(Exp),
            format('Kamu mendapatkan ~d EXP\n',[Exp])
        );
        (
            Count = 0,
            write('Kamu tidak dapat telur sama sekali.\n')    
        )
    ), !.

ranchCow :-
    count(cow(_, 0), Count),
    forall(cow(Name, Days),
        (
            (
                Days = 0,
                addItem(milk, 1),
                NewDays is 5,
                retract(cow(Name, Days)),
                assertz(cow(Name, NewDays))
            );
            (
                Days > 0    
            )
        )
    ),
    (
        (
            Count > 0,
            format('Kamu mendapatkan ~d susu\n',[Count]),
            Exp is Count * 10,
            earnRanchingExp(Exp),
            format('Kamu mendapatkan ~d EXP\n',[Exp])
        );
        (
            Count = 0,
            write('Kamu tidak dapat susu sama sekali.\n')    
        )
    ).

ranchSheep :-
    count(sheep(_, 0),Count),
    forall(sheep(Name, Days),
        (
            (
                Days = 0,
                addItem(wol, 1),
                NewDays is 7,
                retract(sheep(Name, Days)),
                assertz(sheep(Name, NewDays))
            );
            (
                Days > 0    
            )
        )
    ),
    (
        (
            Count > 0,
            format('Kamu mendapatkan ~d wol\n',[Count]),
            Exp is Count * 15,
            earnRanchingExp(Exp),
            format('Kamu mendapatkan ~d EXP\n',[Exp])
        );
        (
            Count = 0,
            write('Kamu tidak dapat wol sama sekali.\n')    
        )
    ).

addChicken(Name) :-
    (
        chicken(Name, _);
        chicks(Name, _)
    ),
    !,
    write('Nama tersebut telah digunakan'), nl,
    write('Masukkan nama:'), nl,
    read(Query),
    addChicken(Query).

addChicken(Name) :- 
    \+chicken(Name, _),
    \+chicks(Name, _),
    assertz(chicken(Name, 3)).

addChicks(Name) :- 
    (
        chicken(Name, _);
        chicks(Name, _)
    ),
    !,
    write('Nama tersebut telah digunakan'), nl,
    write('Masukkan nama:'), nl,
    read(Query),
    addChicken(Query).

addChicks(Name) :- 
    \+chicken(Name, _),
    \+chicks(Name, _),
    assertz(chicks(Name, 3)).

addCow(Name) :- 
    (
        cow(Name, _);
        calf(Name, _)
    ),
    !,
    write('Nama tersebut telah digunakan'), nl,
    write('Masukkan nama:'), nl,
    read(Query),
    addCow(Query).

addCow(Name) :-
    \+cow(Name, _),
    \+calf(Name, _),
    assertz(cow(Name, 5)).

addCalf(Name) :- 
    (
        cow(Name, _);
        calf(Name, _)
    ),
    !,
    write('Nama tersebut telah digunakan'), nl,
    write('Masukkan nama:'), nl,
    read(Query),
    addCalf(Query).
addCalf(Name) :-
    \+cow(Name, _),
    \+calf(Name, _),
    assertz(calf(Name, 14)).

addSheep(Name) :- 
    (
        sheep(Name, _);
        lamb(Name, _)
    ),
    !,
    write('Nama tersebut telah digunakan'), nl,
    write('Masukkan nama:'), nl,
    read(Query),
    addSheep(Query).
addSheep(Name) :-
    \+sheep(Name, _),
    \+lamb(Name, _),
    assertz(sheep(Name, 7)).

addLamb(Name) :- 
    (
        sheep(Name, _);
        lamb(Name, _)
    ),
    !,
    write('Nama tersebut telah digunakan'), nl,
    write('Masukkan nama:'), nl,
    read(Query),
    addLamb(Query).
addLamb(Name) :-
    \+sheep(Name, _),
    \+lamb(Name, _),
    assertz(lamb(Name, 14)).

checkBuyRanch :-
    inventory(Invent),
    ( member([chicken, Total], Invent) ->
        (
            forall(between(1, Total, _),
                (
                    write('Masukkan nama untuk ayam:\n'),
                    read(ChickenName),
                    addChicken(ChickenName),
                    drop(chicken, 1)
                )
            )
        );
        (
            write('')
        )
    ),
    ( member([sheep, Total], Invent) ->
        (
            forall(between(1, Total, _),
                (
                    write('Masukkan nama untuk domba:\n'),
                    read(SheepName),
                    addSheep(SheepName),
                    drop(sheep, 1)
                )
            )
        );
        (
            write('')
        )
    ),
    ( member([cow, Total], Invent) ->
        (
            forall(between(1, Total, _),
                (
                    write('Masukkan nama untuk sapi:\n'),
                    read(CowName),
                    addCow(CowName),
                    drop(cow, 1)
                )
            )
        );
        (
            write('')
        )
    ).


grownRanch :-
    forall(chicks(Name, Days),
        (
            (
                Days = 0,
                retract(chicks(Name, Days)),
                assertz(chicken(Name, 3)),
                format('Anak ayam kamu yang bernama ~w telah tumbuh besar.\n', [Name]),
                Exp is 30,
                earnRanchingExp(Exp),
                format('Kamu mendapatkan ~d EXP\n',[Exp])
            );
            (
                Days > 0    
            )
        )
    ),
    forall(calf(Name, Days),
        (
            (
                Days = 0,
                retract(calf(Name, Days)),
                assertz(cow(Name, 5)),
                format('Anak sapi kamu yang bernama ~w telah tumbuh besar.\n', [Name]),
                Exp is 100,
                earnRanchingExp(Exp),
                format('Kamu mendapatkan ~d EXP\n',[Exp]) 
            );
            (
                Days > 0    
            )
        )
    ),
    forall(lamb(Name, Days),
        (
            (
                Days = 0,
                retract(lamb(Name, Days)),
                assertz(sheep(Name, 7)),
                format('Anak domba kamu yang bernama ~w telah tumbuh besar.\n', [Name]),
                Exp is 100,
                earnRanchingExp(Exp),
                format('Kamu mendapatkan ~d EXP\n',[Exp]) 
            );
            (
                Days > 0    
            )
        )
    ).

babyRanch :-
    forall(incubation(Days),
        (
            Days = 0,
            write('Telur kamu ada yang menetas.'), nl,
            Exp is 30,
            earnRanchingExp(Exp),
            format('Kamu mendapatkan ~d EXP\n',[Exp]),
            write('Masukkan nama:'), nl,
            read(Query),
            addChicks(Query)
        )
    ),
    retractall(incubation(0)),

    forall(pregnantCow(Name, Days),
        (
            Days = 0,
            retract(pregnantCow(Name, Days)),
            format('Sapi kamu yang bernama ~w telah melahirkan.', [Name]), nl,
            Exp is 100,
            earnRanchingExp(Exp),
            format('Kamu mendapatkan ~d EXP\n',[Exp]),
            write('Masukkan nama:'), nl,
            read(Query),
            addCalf(Query)
        )
    ),

    forall(pregnantSheep(Name, Days),
        (
            Days = 0,
            retract(pregnantSheep(Name, Days)),
            format('Domba kamu yang bernama ~w telah melahirkan.', [Name]), nl,
            Exp is 100,
            earnRanchingExp(Exp),
            format('Kamu mendapatkan ~d EXP\n',[Exp]),
            write('Masukkan nama:'), nl,
            read(Query),
            addLamb(Query)
        )
    ).

incubator :-
    \+inventory(_), !,
    write('Maaf kamu tidak memiliki telur'), nl.

incubator :-
    inventory(Invent),
    ( member([egg, _], Invent) ->
        (
            drop(egg, 1),
            assertz(incubation(3)),
            write('Telur kamu sedang dikerami.'), nl
        );
        (
            write('Maaf kamu tidak memiliki telur'), nl
        )
    ).

breedCow :-
    \+inventory(_), !,
    write('Maaf kamu tidak memiliki potion breed untuk sapi'), nl.

breedCow :-
    inventory(Invent),
    ( member([potionBreedCow, _], Invent) ->
        (
            count(cow(_, _), Count),
            (
                (
                    Count = 0, !,
                    write('Maaf kamu tidak memiliki sapi'), nl
                );
                (
                    Count > 0, !,
                    write('Pilih salah satu diantara sapi yang kamu miliki'), nl,
                    forall(cow(Name, _), (write(Name), nl)),
                    read(InputBreedCow),
                    (
                        (
                            InputBreedCow = 'keluar', !
                        );
                        (
                            \+cow(InputBreedCow, _), !,
                            format('Maaf kamu tidak memiliki sapi bernama ~w', [InputBreedCow]), nl,
                            write('Masukkan "keluar", jika ingin keluar'), nl,
                            breedCow
                        );
                        (
                            pregnantCow(InputBreedCow, _), !,
                            format('Maaf sapi kamu yang bernama ~w sedang mengandung', [InputBreedCow]), nl,
                            write('Masukkan "keluar", jika ingin keluar'), nl,
                            breedCow    
                        );
                        (
                            cow(InputBreedCow, _), !,
                            assertz(pregnantCow(InputBreedCow, 14)),
                            drop(potionBreedCow, 1),
                            format('Selamat sapi kamu yang bernama ~w sedang mengandung.', [InputBreedCow])
                        )
                    )
                )
            ), !
        );
        (
            write('Maaf kamu tidak memiliki potion breed untuk sapi'), nl,
            !
        )
    ).

breedSheep :-
    \+inventory(_), !,
    write('Maaf kamu tidak memiliki potion breed untuk domba'), nl.

breedSheep :-
    inventory(Invent),
    ( member([potionBreedSheep, _], Invent) ->
        (
            count(sheep(_, _), Count),
            (
                (
                    Count = 0, !,
                    write('Maaf kamu tidak memiliki domba'), nl
                );
                (
                    Count > 0, !,
                    write('Pilih salah satu diantara domba yang kamu miliki'), nl,
                    forall(sheep(Name, _), (write(Name), nl)),
                    read(InputBreedSheep),
                    (
                        (
                            InputBreedSheep = 'keluar', !
                        );
                        (
                            \+sheep(InputBreedSheep, _), !,
                            format('Maaf kamu tidak memiliki dowba bernama ~w', [InputBreedSheep]), nl,
                            write('Masukkan "keluar", jika ingin keluar'), nl,
                            breedSheep
                        );
                        (
                            pregnantSheep(InputBreedSheep, _), !,
                            format('Maaf domba kamu yang bernama ~w sedang mengandung', [InputBreedSheep]), nl,
                            write('Masukkan "keluar", jika ingin keluar'), nl,
                            breedSheep    
                        );
                        (
                            sheep(InputBreedSheep, _), !,
                            assertz(pregnantSheep(InputBreedSheep, 14)),
                            drop(potionBreedSheep, 1),
                            format('Selamat domba kamu yang bernama ~w sedang mengandung.', [InputBreedSheep])
                        )
                    )
                )
            ), !
        );
        (
            write('Maaf kamu tidak memiliki potion breed untuk domba'), nl,
            !
        )
    ).

updateRanch :- 
    forall(chicken(Name, Days),
    (
            TempDays is Days - 1,
            NewName = Name,
            (
                (
                    TempDays < 0,
                    NewDays is 0
                );
                (
                    TempDays >=0,
                    NewDays is TempDays    
                )
            ),
            retract(chicken(Name, Days)),
            assertz(chicken(NewName, NewDays))
        )
    ),
    
    forall(chicks(Name, Days),
    (
            TempDays is Days - 1,
            NewName = Name,
            (
                (
                    TempDays < 0,
                    NewDays is 0
                );
                (
                    TempDays >=0,
                    NewDays is TempDays    
                )
            ),
            retract(chicks(Name, Days)),
            assertz(chicks(NewName, NewDays))
        )
    ),
    
    forall(cow(Name, Days),
    (
            TempDays is Days - 1,
            NewName = Name,
            (
                (
                    TempDays < 0,
                    NewDays is 0
                );
                (
                    TempDays >=0,
                    NewDays is TempDays    
                )
            ),
            retract(cow(Name, Days)),
            assertz(cow(NewName, NewDays))
        )
    ),
    
    forall(calf(Name, Days),
    (
            TempDays is Days - 1,
            NewName = Name,
            (
                (
                    TempDays < 0,
                    NewDays is 0
                );
                (
                    TempDays >=0,
                    NewDays is TempDays    
                )
            ),
            retract(calf(Name, Days)),
            assertz(calf(NewName, NewDays))
        )
    ),
    
    forall(sheep(Name, Days),
    (
            TempDays is Days - 1,
            NewName = Name,
            (
                (
                    TempDays < 0,
                    NewDays is 0
                );
                (
                    TempDays >=0,
                    NewDays is TempDays    
                )
            ),
            retract(sheep(Name, Days)),
            assertz(sheep(NewName, NewDays))
        )
    ),
    
    forall(lamb(Name, Days),
    (
            TempDays is Days - 1,
            NewName = Name,
            (
                (
                    TempDays < 0,
                    NewDays is 0
                );
                (
                    TempDays >=0,
                    NewDays is TempDays    
                )
            ),
            retract(lamb(Name, Days)),
            assertz(lamb(NewName, NewDays))
        )
    ),

    forall(pregnantCow(Name, Days),
    (
            TempDays is Days - 1,
            NewName = Name,
            (
                (
                    TempDays < 0,
                    NewDays is 0
                );
                (
                    TempDays >=0,
                    NewDays is TempDays    
                )
            ),
            retract(pregnantCow(Name, Days)),
            assertz(pregnantCow(NewName, NewDays))
        )
    ),

    forall(pregnantSheep(Name, Days),
    (
            TempDays is Days - 1,
            NewName = Name,
            (
                (
                    TempDays < 0,
                    NewDays is 0
                );
                (
                    TempDays >=0,
                    NewDays is TempDays    
                )
            ),
            retract(pregnantSheep(Name, Days)),
            assertz(pregnantSheep(NewName, NewDays))
        )
    ),

    forall(incubation(Days),
    (
            TempDays is Days - 1,
            NewName = Name,
            (
                (
                    TempDays < 0,
                    NewDays is 0
                );
                (
                    TempDays >=0,
                    NewDays is TempDays    
                )
            ),
            retract(incubation(Days)),
            assertz(incubation(NewDays))
        )
    ).

ranch :-
    \+state(free), !,
    write('Permainan belum dimulai\n').

ranch :-
    state(free),
    \+playerCell('R'), !,
    write('Kamu sedang tidak ada di Peternakan.\n').

ranch :-
    write('Selamat datang di Peternakan !!!'), nl,
    write('Apa yang ingin kamu lakukan : '), nl,
    write('1. Lihat hewan ternak'), nl,
    write('2. Ambil hasil'), nl,
    write('3. Incubator'), nl,
    write('4. Mengembangbiakkan sapi'), nl,
    write('5. Mengembangbiakkan domba'), nl,
    read(Pilihan),
    (
        (
            Pilihan = 1, !,
            lihatHewanTernak,
            write('kamu telah keluar dari Peternakan.\n'),
            setState(free)
        );
        (
            Pilihan = 2, !,
            ambilHasil,
            write('kamu telah keluar dari Peternakan.\n'),
            setState(free)
        );
        (
            Pilihan = 3,
            incubator, !,
            write('kamu telah keluar dari Peternakan.\n'),
            setState(free)
        );
        (
            Pilihan = 4,
            breedCow, !,
            write('kamu telah keluar dari Peternakan.\n'),
            setState(free)
        );
        (
            Pilihan = 5,
            breedSheep, !,
            write('kamu telah keluar dari Peternakan.\n'),
            setState(free)
        )
    ).