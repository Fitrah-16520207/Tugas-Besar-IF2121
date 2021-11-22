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

:- dynamic(baseExp/1).
:- dynamic(baseExpFish/1).
:- dynamic(baseExpFarm/1).
:- dynamic(baseExpRanch/1).

:- dynamic(gold/1).
:- dynamic(days/1).

reset :-
    retractall(playerName(_)),
    retractall(playerJob(_)),
    retractall(level(_)),
    retractall(levelFishing(_)),
    retractall(levelFarming(_)),
    retractall(levelRanching(_)),
    retractall(experience(_)),
    retractall(experienceFishing(_)),
    retractall(experienceFarming(_)),
    retractall(experienceRanching(_)),
    retractall(gold(_)).

baseStats :-
    asserta(level(1)),
    asserta(levelFishing(1)),
    asserta(levelFarming(1)),
    asserta(levelRanching(1)),

    asserta(experience(0)),
    asserta(experienceFishing(0)),
    asserta(experienceFarming(0)),
    asserta(experienceRanching(0)),

    asserta(baseExp(15)),
    asserta(baseExpFarm(7)),
    asserta(baseExpFish(7)),
    asserta(baseExpRanch(7)),
    asserta(gold(1000)),

    asserta(playerJob(rancher)).

% Set Rules 
setState(fisherman) :-
    asserta(playerJob(fisherman)).

setState(farmer) :-
    asserta(playerJob(farmer)).

setState(rancher) :-
    asserta(playerJob(rancher)).

% 
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
    asserta(gold(NewGold)).

% Level Up System
levelUp() :-
    level(CurrLvl),

    retractall(experience(_)),
    retractall(level(_)),
    retractall(levelUpCap(_)),

    NewLvl is CurrLvl + 1,
    NewLUC is 7 * (2 ** NewLvl) + NewLvl,

    asserta(level(NewLvl)),
    asserta(levelUpCap(NewLUC)),

    format('Congratulation, now your level is ~w', [NewLvl]).


% Status Window
status() :-
    level(Lvl),
    levelFarming(LvlFarm),
    levelFishing(LvlFish),
    levelRanching(LvlRanch),
    experience(Exp),
    experienceFarming(ExpFarm),
    experienceFishing(ExpFish),
    experienceRanching(ExpRanch),
    baseExp(BExp),
    baseExpFarm(BExpFarm),
    baseExpFish(BExpFish),
    baseExpRanch(BExpRanch),
    gold(Gold),

    write('Your status:'), nl,
    statusJob(), nl,
    format('Level: ~d', [Lvl]), nl,
    format('Level farming: ~d', [LvlFarm]), nl,
    format('Exp farming: ~d/~d', [ExpFarm, BExpFarm]), nl,
    format('Level fishing: ~d', [LvlFish]), nl,
    format('Exp fishing: ~d/~d', [ExpFish, BExpFish]), nl,
    format('Level ranching: ~d', [LvlRanch]), nl,
    format('Exp ranching: ~d/~d', [ExpRanch, BExpRanch]), nl,
    format('Exp: ~d/~d', [Exp, BExp]), nl,
    format('Gold: ~d', [Gold]), nl.

statusJob() :-
    (
        playerJob(fisherman), !,
        write('Job: Fisherman')
    );
    (
        playerJob(farmer), !,
        write('Job: Farmer')   
    );
    (
        playerJob(rancher), !,
        write('Job: Rancher')    
    ).
