:- dynamic(playerName/1).
:- dynamic(playerJob/1).

:- dynamic(level/1).
:- dynamic(levelFishing/1).
:- dynamic(levelFarming/1).
:- dynamic(levelRanching/1).

:- dynamic(levelUpCap/1).
:- dynamic(levelUpCapFishing/1).
:- dynamic(levelUpCapFarming/1).
:- dynamic(levelUpCapRanching/1).

:- dynamic(experience/1).
:- dynamic(experienceFishing/1).
:- dynamic(experienceFarming/1).
:- dynamic(experienceRanching/1).

:- dynamic(gold/1).
:- dynamic(days/1).

% Reset semua status yang dimiliki
reset :-
    retractall(playerName(_)),
    retractall(playerJob(_)),

    retractall(level(_)),
    retractall(levelFishing(_)),
    retractall(levelFarming(_)),
    retractall(levelRanching(_)),

    retractall(levelUpCap(_)),
    retractall(levelUpCapFarming(_)),
    retractall(levelUpCapFishing(_)),
    retractall(levelRanching(_)),

    retractall(experience(_)),
    retractall(experienceFishing(_)),
    retractall(experienceFarming(_)),
    retractall(experienceRanching(_)),

    retractall(gold(_)),
    retractall(days(_)).

% Set semua status dengan state awal permainan
baseStats :-
    asserta(level(1)),
    asserta(levelFishing(1)),
    asserta(levelFarming(1)),
    asserta(levelRanching(1)),

    asserta(experience(0)),
    asserta(experienceFishing(0)),
    asserta(experienceFarming(0)),
    asserta(experienceRanching(0)),

    asserta(levelUpCap(15)),
    asserta(levelUpCapFarming(7)),
    asserta(levelUpCapFishing(7)),
    asserta(levelUpCapRanching(7)),
    asserta(gold(1000)),

    asserta(days(1)).

% Set Rules 
setJob(fisherman) :-
    asserta(playerJob(fisherman)),
    asserta(inventory([[normal_rod, 1], [bait, 8]])),
    write('Kamu berhasil menjadi fisherman'),nl,
    write('Sebagai fisherman, kamu berhak memperoleh satu buah pancingan biasa dan delapan umpan\n').

setJob(farmer) :-
    asserta(playerJob(farmer)),
    asserta(inventory([[shovel, 1], [potato_seed, 3]])),
    write('Kamu berhasil menjadi farmer\n'),
    write('Sebagai farmer, kamu berhak memperoleh satu buah sekop dan tiga benih potato\n').

setJob(rancher) :-
    asserta(playerJob(rancher)),
    write('Kamu berhasil menjadi rancher\n'),
    write('Sebagai rancher, kamu berhak memperoleh dua ekor ayam\n'),
    write('Masukkan nama untuk ayam:\n'), read(Input1),
    addChicken(Input1), nl,
    write('Masukkan nama untuk ayam:\n'), read(Input2),
    addChicken(Input2), nl.


% Sistem menambahkan EXP
earnExp(X) :-
    experience(CurrExp),
    NewExp is CurrExp + X,
    retractall(experience(_)),
    asserta(experience(NewExp)),
    checkLevelUp.

earnFishingExp(X) :-
    experience(CurrExp),
    experienceFishing(CurrExpFish),
    NewExp is CurrExp + X,
    NewExpFish is CurrExpFish + X,
    retractall(experience(_)),
    retractall(experienceFishing(_)),
    asserta(experience(NewExp)),
    asserta(experienceFishing(NewExpFish)),
    checkLevelUp.

earnFarmingExp(X) :-
    experience(CurrExp),
    experienceFarming(CurrExpFarm),
    NewExp is CurrExp + X,
    NewExpFarm is CurrExpFarm + X,
    retractall(experience(_)),
    retractall(experienceFarming(_)),
    asserta(experience(NewExp)),
    asserta(experienceFarming(NewExpFarm)),
    checkLevelUp.

earnRanchingExp(X) :-
    experience(CurrExp),
    experienceRanching(CurrExpRanch),
    NewExp is CurrExp + X,
    NewExpRanch is CurrExpRanch + X,
    retractall(experience(_)),
    retractall(experienceRanching(_)),
    asserta(experience(NewExp)),
    asserta(experienceRanching(NewExpRanch)),
    checkLevelUp.

earnGold(X) :-
    gold(CurrGold),
    NewGold is CurrGold + X,
    retractall(gold(_)),
    asserta(gold(NewGold)),
    (
        (
            NewGold > 19999,
            setState(finished),
            write('HOREEE!!!\n'),
            format('Kamu telah berhasil mengumpulkan uang sebanyak ~w Gold\n', [NewGold]),
            write('Kamu telah mampu untuk membayar segala utangmu, yeayy\n'),
            write('Permainan Selesai')
        );
        (
            write('')
        )
    ).

% Level Up System
levelUp :-

    level(CurrLvl),
    experience(CurrExp),
    levelUpCap(LUC),

    CurrExp >= LUC, !,

    retractall(experience(_)),
    retractall(level(_)),
    retractall(levelUpCap(_)),

    NewLvl is CurrLvl + 1,
    NewExp is CurrExp - LUC,
    NewLUC is round(7 * (2 ** NewLvl) + NewLvl),

    asserta(level(NewLvl)),
    asserta(levelUpCap(NewLUC)),
    asserta(experience(NewExp)),

    format('Selamat, level kamu sekarang adalah ~w\n', [NewLvl]), !.
levelUp.

levelUpFarming :-
    levelFarming(CurrLvl),
    experienceFarming(CurrExp),
    levelUpCapFarming(LUC),

    CurrExp >= LUC, !,
    
    retractall(levelFarming(_)),
    retractall(experienceFarming(_)),
    retractall(levelUpCapFarming(_)),

    NewLvl is CurrLvl + 1,
    NewExp is CurrExp - LUC,
    NewLUC is round(3 * (2 ** NewLvl) + NewLvl),
    integer(NewLUC),

    asserta(levelFarming(NewLvl)),
    asserta(levelUpCapFarming(NewLUC)),
    asserta(experienceFarming(NewExp)),

    format('Selamat, sekarang level farming kamu adalah ~w', [NewLvl]), !, nl,
    (
        (
            NewLvl = 3,
            unlockedItem(carrot_seed),
            unlockedItem(best_fertilizer),
            write('Carrot Seed dan Best Fertilizer telah terbuka, silakan cek marketplace untuk lebih detail\n'), !
        );
        (
            NewLvl = 7,
            unlockedItem(rice_seed),
            unlockedItem(instant_fertilizer),
            write('Rice Seed dan Instant Fertilizer telah terbuka, silakan cek marketplace untuk lebih detail\n'), !
        );
        (
            write('')
        )
    ).
levelUpCapFarming.

levelUpFishing :-
    levelFishing(CurrLvl),
    experienceFishing(CurrExp),
    levelUpCapFishing(LUC),

    CurrExp >= LUC, !,
    
    retractall(levelFishing(_)),
    retractall(experienceFishing(_)),
    retractall(levelUpCapFishing(_)),

    NewLvl is CurrLvl + 1,
    NewExp is CurrExp - LUC,
    NewLUC is round(3 * (2 ** NewLvl) + NewLvl),
    

    asserta(levelFishing(NewLvl)),
    asserta(levelUpCapFishing(NewLUC)),
    asserta(experienceFishing(NewExp)),

    format('Selamat, sekarang level fishing kamu adalah ~w', [NewLvl]), !, nl,
    (
        (
            NewLvl = 3,
            unlockedItem(rare_rod),
            write('Rare Rod telah terbuka, silakan cek marketplace untuk lebih detail\n'), !
        );
        (
            NewLvl = 7,
            unlockedItem(legend_rod),
            write('Legend Rode telah terbuka, silakan cek marketplace untuk lebih detail\n'), !
        );
        (
            write('')
        )
    ).
levelUpCapFishing.

levelUpRanching :-
    levelRanching(CurrLvl),
    experienceRanching(CurrExp),
    levelUpCapRanching(LUC),

    CurrExp >= LUC, !,
    
    retractall(levelRanching(_)),
    retractall(experienceRanching(_)),
    retractall(levelUpCapRanching(_)),

    NewLvl is CurrLvl + 1,
    NewExp is CurrExp - LUC,
    NewLUC is round(3 * (2 ** NewLvl) + NewLvl),

    asserta(levelRanching(NewLvl)),
    asserta(levelUpCapRanching(NewLUC)),
    asserta(experienceRanching(NewExp)),

    format('Selamat, sekarang level ranching kamu adalah ~w', [NewLvl]), !, nl,
    (
        (
            NewLvl = 3, 
            unlockedItem(sheep),
            unlockedItem(potionBreedSheep),
            write('Sheep dan potion breed sheep telah terbuka, silakan cek marketplace untuk lebih detail\n'), !
        );
        (
            NewLvl = 7,
            unlockedItem(cow),
            unlockedItem(potionBreedCow),
            write('Cow dan potion breed cow telah terbuka, silakan cek marketplace untuk lebih detail\n'), !
        );
        (
            write(''), !
        )
    ).
levelUpCapRanching.

checkLevelUp :-
    experience(Exp),
    levelUpCap(LUC),
    experienceFarming(ExpFarm),
    levelUpCapFarming(LUCFarm),
    experienceFishing(ExpFish),
    levelUpCapFishing(LUCFish),
    experienceRanching(ExpRanch),
    levelUpCapRanching(LUCRanch),
    (
        (
            Exp >= LUC,
            levelUp, !,
            checkLevelUp
        );
        (
            Exp < LUC
        )
    ),
    (
        (
            ExpFarm >= LUCFarm,
            levelUpFarming, !,
            checkLevelUp
        );
        (
            ExpFarm < LUCFarm
        )
    ),
    (
        (
            ExpFish >= LUCFish,
            levelUpFishing, !,
            checkLevelUp
        );
        (
            ExpFish < LUCFish
        )
    ),
    (
        (
            ExpRanch >= LUCRanch,
            levelUpRanching, !,
            checkLevelUp
        );
        (
            ExpRanch < LUCRanch
        )
    ).

% Status Window
status :-
    level(Lvl),
    levelFarming(LvlFarm),
    levelFishing(LvlFish),
    levelRanching(LvlRanch),
    experience(Exp),
    experienceFarming(ExpFarm),
    experienceFishing(ExpFish),
    experienceRanching(ExpRanch),
    levelUpCap(LUC),
    levelUpCapFarming(LUCFarm),
    levelUpCapFishing(LUCFish),
    levelUpCapRanching(LUCRanch),
    gold(Gold),

    write('Your status:'), nl,
    statusJob, nl,
    format('Level: ~w', [Lvl]), nl,
    format('Level farming: ~w', [LvlFarm]), nl,
    format('Exp farming: ~w/~w', [ExpFarm, LUCFarm]), nl,
    format('Level fishing: ~w', [LvlFish]), nl,
    format('Exp fishing: ~w/~w', [ExpFish, LUCFish]), nl,
    format('Level ranching: ~w', [LvlRanch]), nl,
    format('Exp ranching: ~w/~w', [ExpRanch, LUCRanch]), nl,
    format('Exp: ~w/~w', [Exp, LUC]), nl,
    format('Gold: ~w', [Gold]), nl, !. 

statusJob :-
    (
        playerJob(fisherman),
        write('Job: Fisherman')
    );
    (
        playerJob(farmer),
        write('Job: Farmer')   
    );
    (
        playerJob(rancher),
        write('Job: Rancher')    
    ).

% Menambahkan hari
addDays :-
    days(CurrDays),
    retractall(days(_)),
    NewDays is CurrDays + 1,
    asserta(days(NewDays)),
    updateRanch, babyRanch, grownRanch,
    (
        (
            NewDays > 120,
            setState(finished),
            write('Hari ternyata berlalu begitu cepat\n'),
            write('Hari ini tepat satu tahun telah kamu lalui\n'),
            write('Namun apa daya, uang kamu belum cukup untuk membayar segala utangmu\n'),
            write('Kamu telah gagal!!!\n'),
            write('Permainan Selesai')
        );
        (
            write('')
        )
    ).