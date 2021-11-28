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
    write('Kamu berhasil menjadi fisherman\n'),
    write('Sebagai fisherman, kamu berhak memperoleh satu buah pancingan biasa dan delapan umpan\n').

setJob(farmer) :-
    asserta(playerJob(farmer)),
    asserta(inventory([[shovel, 1], [potato_seed, 3]])),
    write('Kamu berhasil menjadi farmer\n'),
    write('Sebagai farmer, kamu berhak memperoleh satu buah sekop dan tiga benih potato\n').

setJob(rancher) :-
    asserta(playerJob(rancher)),
    asserta(inventory([[chicken, 2]])),
    write('Kamu berhasil menjadi rancher\n'),
    write('Sebagai rancher, kamu berhak memperoleh dua ekor ayam\n').


% Sistem menambahkan EXP
earnExp(X) :-
    experience(CurrExp),
    NewExp is CurrExp + X,
    retractall(experience(_)),
    asserta(experience(NewExp)).

earnFishingExp(X) :-
    experience(CurrExp),
    experienceFishing(CurrExpFish),
    NewExp is CurrExp + X,
    NewExpFish is CurrExpFish + X,
    retractall(experience(_)),
    retractall(experienceFishing(_)),
    asserta(experience(NewExp)),
    asserta(experienceFishing(NewExpFish)).

earnFarmingExp(X) :-
    experience(CurrExp),
    experienceFarming(CurrExpFarm),
    NewExp is CurrExp + X,
    NewExpFarm is CurrExpFarm + X,
    retractall(experience(_)),
    retractall(experienceFarming(_)),
    asserta(experience(NewExp)),
    asserta(experienceFishing(NewExpFarm)).

earnRanchingExp(X) :-
    experience(CurrExp),
    experienceRanching(CurrExpRanch),
    NewExp is CurrExp + X,
    NewExpRanch is CurrExpRanch + X,
    retractall(experience(_)),
    retractall(experienceRanching(_)),
    asserta(experience(NewExp)),
    asserta(experienceRanching(NewExpRanch)).

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
            write('Kamu telah berhasil mengumpulkan uang sebanyak ~w Gold\n', [NewGold]),
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

    retractall(experience(_)),
    retractall(level(_)),
    retractall(levelUpCap(_)),

    NewLvl is CurrLvl + 1,
    NewExp is CurrExp - LUC,
    NewLUC is 7 * (2 ** NewLvl) + NewLvl,

    asserta(level(NewLvl)),
    asserta(levelUpCap(NewLUC)),
    asserta(experience(NewExp)),

    format('Selamat, level kamu sekarang adalah ~w', [NewLvl]), !.

levelUpFarming :-
    levelFarming(CurrLvl),
    experienceFarming(CurrExp),
    levelUpCapFarming(LUC),
    
    retractall(levelFarming(_)),
    retractall(experienceFarming(_)),
    retractall(levelUpCapFarming(_)),

    NewLvl is CurrLvl + 1,
    NewExp is CurrExp - LUC,
    NewLUC is 7 * (2 ** NewLvl) + NewLvl,

    asserta(levelFarming(NewLvl)),
    asserta(levelUpCapFarming(NewLUC)),
    asserta(experienceFarming(NewExp)),

    format('Selamat, sekarang level farming kamu adalah : ~w', [NewLvl]), !, nl,
    (
        (
            NewLvl = 3, !,
            unlockedItem(carrot_seed),
            unlockedItem(best_fertilizer),
            write('Carrot Seed dan Best Fertilizer telah terbuka, silakan cek marketplace untuk lebih detail')
        );
        (
            NewLvl = 7, !,
            unlockedItem(rice_seed),
            unlockedItem(instant_fertilizer),
            write('Rice Seed dan Instant Fertilizer telah terbuka, silakan cek marketplace untuk lebih detail')
        );
        (
            write('')
        )
    ).

levelUpFishing :-
    levelFishing(CurrLvl),
    experienceFishing(CurrExp),
    levelUpCapFishing(LUC),
    
    retractall(levelFishing(_)),
    retractall(experienceFishing(_)),
    retractall(levelUpCapFishing(_)),

    NewLvl is CurrLvl + 1,
    NewExp is CurrExp - LUC,
    NewLUC is 7 * (2 ** NewLvl) + NewLvl,

    asserta(levelFishing(NewLvl)),
    asserta(levelUpCapFishing(NewLUC)),
    asserta(experienceFishing(NewExp)),

    format('Selamat, sekarang level fishing kamu adalah ~w', [NewLvl]), !, nl,
    (
        (
            NewLvl = 3, !,
            unlockedItem(rare_rod),
            write('Rare Rod telah terbuka, silakan cek marketplace untuk lebih detail')
        );
        (
            NewLvl = 7, !,
            unlockedItem(legend_rod),
            write('Legend Rode telah terbuka, silakan cek marketplace untuk lebih detail')
        );
        (
            write('')
        )
    ).

levelUpRanching :-
    levelRanching(CurrLvl),
    experienceRanching(CurrExp),
    levelUpCapRanching(LUC),
    
    retractall(levelRanching(_)),
    retractall(experienceRanching(_)),
    retractall(levelUpCapRanching(_)),

    NewLvl is CurrLvl + 1,
    NewExp is CurrExp - LUC,
    NewLUC is 7 * (2 ** NewLvl) + NewLvl,

    asserta(levelRanching(NewLvl)),
    asserta(levelUpCapRanching(NewLUC)),
    asserta(experienceRanching(NewExp)),

    format('Selamat, sekarang level fishing kamu adalah ~w', [NewLvl]), !, nl,
    (
        (
            NewLvl = 3, !,
            unlockedItem(sheep),
            write('Sheep telah terbuka, silakan cek marketplace untuk lebih detail')
        );
        (
            NewLvl = 7, !,
            unlockedItem(cow),
            write('Cow telah terbuka, silakan cek marketplace untuk lebih detail')
        );
        (
            write('')
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
    format('Level: ~d', [Lvl]), nl,
    format('Level farming: ~d', [LvlFarm]), nl,
    format('Exp farming: ~d/~d', [ExpFarm, LUCFarm]), nl,
    format('Level fishing: ~d', [LvlFish]), nl,
    format('Exp fishing: ~d/~d', [ExpFish, LUCFish]), nl,
    format('Level ranching: ~d', [LvlRanch]), nl,
    format('Exp ranching: ~d/~d', [ExpRanch, LUCRanch]), nl,
    format('Exp: ~d/~d', [Exp, LUC]), nl,
    format('Gold: ~d', [Gold]), nl, !. 

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