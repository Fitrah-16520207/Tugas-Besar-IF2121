:- dynamic(activeQuest/5).
:- dynamic(availableQuest/1).

addToList(NewList, [], [NewList]).
addToList(NewList, [HOldList|TOldList], Return) :- 
    addToList(NewList, TOldList, TailReturn), 
    Return = [HOldList|TailReturn].

countList([], 0).
countList([_|T], Nb) :- countList(T, NbNew), Nb is NbNew + 1.

getNth([H|_], 1, H).
getNth([_|T], Num, Return) :-
    NewNum is Num - 1,
    getNth(T, NewNum, Get),
    Return = Get.

getDataQuest([H1|T1], Fish, Farm, Ranch, Gold, Exp) :-
    Fish is H1,
    [H2|T2] = T1,
    Farm is H2,
    [H3|T3] = T2,
    Ranch is H3,
    [H4|T4] = T3,
    Gold is H4,
    [H5|_] = T4,
    Exp is H5.

addQuest(Quest) :-
    \+availableQuest(_), 
    asserta(availableQuest([Quest])).

addQuest(Quest) :-
    availableQuest(OldAvailableQuest),
    removeAvailableQuest,
    addToList(Quest, OldAvailableQuest, NewAvailableQuest),
    asserta(availableQuest(NewAvailableQuest)).

removeAvailableQuest :-
    availableQuest(_),
    !,
    retractall(availableQuest(_)).
removeAvailableQuest.

removeActiveQuest :-
    activeQuest(_, _, _, _, _),
    !,
    retractall(activeQuest(_, _, _, _, _)).
    removeActiveQuest.

generateQuest :-
    removeActiveQuest,
    removeAvailableQuest,
    (
        random(0, 10, Fish),
        Exp1 is round(Fish*3/2),
        Gold1 is Fish*50,
        addQuest([Fish, 0, 0, Gold1, Exp1])
    ),
    (
        random(0, 5, Farm),
        Exp2 is round(Farm * 5 / 3),
        Gold2 is Farm*75,
        addQuest([0, Farm, 0, Gold2, Exp2])
    ),
    (
        random(0, 7, Ranch),
        Exp3 is Ranch*2,
        Gold3 is Ranch*100,
        addQuest([0, 0, Ranch, Gold3, Exp3])
    ),
    (
        forall(between(1,3,_), (
            random(0, 10, Fish1),
            random(0, 5, Farm1),
            random(0, 7, Ranch1),
            TotalGold is Fish1 * 50 + Farm1 * 75 + Ranch1 * 100,
            ExpFish is round(Fish1*3/2),
            ExpFarm is round(Farm1*5/3),
            ExpRanch is Ranch1*2,
            TotalExp is ExpFish + ExpFarm + ExpRanch,
            addQuest([Fish1, Farm1, Ranch1, TotalGold, TotalExp])
            )
        )
    ), !.

setActiveQuest(Quest) :-
    removeActiveQuest,
    asserta(activeQuest(Quest)).


printQuestBoard :-
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
    write('                                 ~Quest Board~                                  '), nl, nl,
    availableQuest(Q),
    printQuestBoard(1, Q), nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').
    
printQuestBoard(X, [[Fish, Farm, Ranch, Gold, Exp]]) :-
    format('    ~d. ~d Ikan, ~d Hasil panen, dan ~d Hasil ternak', [X, Fish, Farm, Ranch]), nl,
    format('       Hadiah: ~d Gold dan ~d Exp', [Gold, Exp]), nl.
printQuestBoard(X, [[Fish, Farm, Ranch, Gold, Exp]|Tail]) :-
    format('    ~d. ~d Ikan, ~d Hasil panen, dan ~d Hasil ternak', [X, Fish, Farm, Ranch]), nl,
    format('       Hadiah: ~d Gold dan ~d Exp', [Gold, Exp]), nl,
    NextX is X + 1,
    printQuestBoard(NextX, Tail),
    !.

printQuest :-
    \+activeQuest(_, _, _, _, _),
    !,
    write('Tidak ada quest yang berlangsung.').
printQuest :-
    activeQuest(Fish, Farm, Ranch, Gold, Exp),
    !,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl,
    write('                                 ~Active Quest~                                 '), nl, nl,
    format('    Ikan         : ~d', [Fish]), nl,
    format('    Hasil panen  : ~d', [Farm]), nl,
    format('    Hasil ternak : ~d', [Ranch]), nl,
    format('    Hadiah       : ~d Gold dan ~d Exp', [Gold, Exp]), nl, nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%').

earnReward :-
    activeQuest(_, _, _, Gold, Exp),
    earnExp(Exp),
    earnGold(Gold).

cekActiveQuest :-
    activeQuest(Fish, Farm, Ranch, _, _),
    Fish = 0,
    Farm = 0,
    Ranch = 0,
    earnReward,
    removeActiveQuest, !.

updateActiveQuest(Item, Total) :-
    activeQuest(Fish, Farm, Ranch, Gold, Exp),
    (
        (
            Item = 'fish',
            NewFish is Fish - Total,
            NewFish >= 0,
            !,
            removeActiveQuest,
            asserta(activeQuest(NewFish, Farm, Ranch, Gold, Exp))
        );
        (
            Item = 'fish',
            NewFish is Fish - Total,
            NewFish < 0,
            NewFish is 0,
            !,
            removeActiveQuest,
            asserta(activeQuest(NewFish, Farm, Ranch, Gold, Exp))
        );
        (
            Item = 'farm',
            NewFarm is Farm - Total,
            NewFarm >= 0,
            !,
            removeActiveQuest,
            asserta(activeQuest(Fish, NewFarm, Ranch, Gold, Exp))
        );
        (
            Item = 'farm',
            NewFarm is Farm - Total,
            NewFarm < 0,
            NewFarm is 0,
            !,
            removeActiveQuest,
            asserta(activeQuest(Fish, NewFarm, Ranch, Gold, Exp))
        );
        (
            Item = 'ranch',
            NewRanch is Fish - Total,
            NewFish >= 0,
            !,
            removeActiveQuest,
            asserta(activeQuest(NewFish, Farm, NewRanch, Gold, Exp))
        );
        (
            Item = 'ranch',
            NewRanch is Fish - Total,
            NewFish < 0,
            NewFish is 0,
            !,
            removeActiveQuest,
            asserta(activeQuest(NewFish, Farm, NewRanch, Gold, Exp))
        )
    ),
    cekActiveQuest,
    !.
updateActiveQuest(_).

quest :-
    \+state(free), !,
    write('Permainan belum dimulai.').

quest :- 
    state(free),
    \+playerCell('Q'), !,
    write('Kamu sedang tidak ada di Quest Board (Q)!\n').

quest :-
    state(free),
    activeQuest(_, _, _, _, _),
    !,
    write('Kamu belum menyelesaikan Quest kamu!\n').

quest :-
    state(free),
    setState(quest),
    generateQuest,
    printQuestBoard, nl, nl,
    write('Pilih Quest yang diinginkan \nInput sesuai dengan nomor Quest yang diinginkan, \nInput yang lainnya untuk keluar.'),
    read(Query),
    (
        integer(Query),
        availableQuest(Q),
        countList(Q, NbAvailableQuest),
        Query >= 0,
        Query =< NbAvailableQuest,
        getNth(Q, Query, QuestPicked),
        getDataQuest(QuestPicked, Fish, Farm, Ranch, Gold, Exp),
        removeActiveQuest,
        asserta(activeQuest(Fish, Farm, Ranch, Gold, Exp)),
        removeAvailableQuest,
        format('Kamu telah mengambil quest nomor ~d.\n', [Query]),
        write('Kamu telah keluar dari quest board.\n'),
        setState(free),
        !
    );
    (
        Query = quit,
        write('Kamu telah keluar dari quest board.\n'),
        setState(free),
        !    
    ).
