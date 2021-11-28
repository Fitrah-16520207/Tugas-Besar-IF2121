% spesifikasi map
% ukuran ditentukan sebesar 10 baris x 15 kolom (tidak termasuk pagar)
% titik yang dapat diakses pada pojok kiri atas adalah (1,1),
% pojok kanan bawah adalah (10, 15)
% pagar ada di (0, Ry), (11, Ry) dan (Rx, 0), (Rx, 16) dengan 0<=Ry<=16 dan 0<=Rx<=11


:- dynamic(playerPoint/2).
:- dynamic(playerCell/1).
% playerCell dapat berupa:
% 'H' : house
% 'R' : ranch
% 'M' : marketplace
% 'Q' : quest
% 'o' : di sekitar water tile
% '=' : digged tile
% 'p' : potato
% 'c' : carrot
% 't' : tomato
% 'r' : rice
% '-' : tanah

% awal permainan, pemain akan berada di rumah
playerCell('H').
playerPoint(5, 8).

% koordinat lokasi
nRow(11).
nCol(16).
housePoint(5, 8).
ranchPoint(2, 12).
marketplacePoint(3, 2).
questPoint(10, 8).

waterTilePoint(7, 7).
waterTilePoint(7, 8).
waterTilePoint(7, 9).
waterTilePoint(8, 6).
waterTilePoint(8, 7).
waterTilePoint(8, 8).
waterTilePoint(8, 9).
waterTilePoint(8, 10).

fence(R, _) :- R = 0; nRow(R).
fence(_, C) :- C = 0; nCol(C).

% farming
:- dynamic(diggedTilePoint/2).
:- dynamic(potatoTilePoint/2).
:- dynamic(carrotTilePoint/2).
:- dynamic(tomatoTilePoint/2).
:- dynamic(riceTilePoint/2).

% printMap
printCell(R, C) :-
    fence(R, C),
    !,
    write('#').
printCell(R, C) :-
    playerPoint(R, C),
    !,
    write('P').
printCell(R, C) :-
    housePoint(R, C),
    !,
    write('H').
printCell(R, C) :-
    ranchPoint(R, C),
    !,
    write('R').
printCell(R, C) :-
    marketplacePoint(R, C),
    !,
    write('M').
printCell(R, C) :-
    questPoint(R, C),
    !,
    write('Q').
printCell(R, C) :-
    waterTilePoint(R, C),
    !,
    write('o').
printCell(R, C) :-
    diggedTilePoint(R, C),
    !,
    write('=').
printCell(R, C) :-
    potatoTilePoint(R, C),
    !,
    write('p').
printCell(R, C) :-
    carrotTilePoint(R, C),
    !,
    write('c').
printCell(R, C) :-
    tomatoTilePoint(R, C),
    !,
    write('t').
printCell(R, C) :-
    riceTilePoint(R, C),
    !,
    write('r').
printCell(_,_) :-
	write('-').

map :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.\n').
map :-
    nRow(R),
	nCol(C),
	forall(between(0,R,I),(
		forall(between(0,C,J),(
			printCell(I,J)
		)),
		nl
	)).

% exploration mechanism
w :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.\n').
w :-
    playerPoint(R, C),
    NewR is R - 1,
    fence(NewR, C),
    !, 
    write('Kamu mencoba meloncati pagar di utara tapi kamu tersangkut').
w :-
    playerPoint(R, C),
    NewR is R - 1,
    waterTilePoint(NewR, C),
    !, 
    write('Kamu enggak boleh nyebur ke sungai karena kamu tidak bisa berenang').
w :-
    state(S),
    S \= free, !,
    format('Kamu harus keluar dulu dari ~w agar bisa bergerak ke utara\n', [S]).
w :-
    playerPoint(R, C),
    NewR is R - 1,
    retractall(playerPoint(_, _)),
    asserta(playerPoint(NewR, C)),
    !,
    write('Kamu berhasil bergerak ke utara'), nl,
    cellCheck(NewR, C).

s :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.\n').
s :-
    playerPoint(R, C),
    NewR is R + 1,
    fence(NewR, C),
    !, 
    write('Kamu mencoba meloncati pagar di selatan tapi kamu tersangkut').
s :-
    playerPoint(R, C),
    NewR is R + 1,
    waterTilePoint(NewR, C),
    !, 
    write('Kamu enggak boleh nyebur ke sungai karena kamu tidak bisa berenang').
s :-
    state(S),
    S \= free, !,
    format('Kamu harus keluar dulu dari ~w agar bisa bergerak ke selatan\n', [S]).
s :-
    playerPoint(R, C),
    NewR is R + 1,
    retractall(playerPoint(_, _)),
    asserta(playerPoint(NewR, C)),
    !,
    write('Kamu berhasil bergerak ke selatan'), nl,
    cellCheck(NewR, C).

a :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.\n').
a :-
    playerPoint(R, C),
    NewC is C - 1,
    fence(R, NewC),
    !, 
    write('Kamu mencoba meloncati pagar di barat tapi kamu tersangkut').
a :-
    playerPoint(R, C),
    NewC is C - 1,
    waterTilePoint(R, NewC),
    !, 
    write('Kamu enggak boleh nyebur ke sungai karena kamu tidak bisa berenang').
a :-
    state(S),
    S \= free, !,
    format('Kamu harus keluar dulu dari ~w agar bisa bergerak ke barat\n', [S]).
a :-
    playerPoint(R, C),
    NewC is C - 1,
    retractall(playerPoint(_, _)),
    asserta(playerPoint(R, NewC)),
    !,
    write('Kamu berhasil bergerak ke barat'), nl,
    cellCheck(R, NewC).

d :-
  state(S),
  S = not_started, !,
  write('Permainan belum dimulai.\n').
d :-
    playerPoint(R, C),
    NewC is C + 1,
    fence(R, NewC),
    !, 
    write('Kamu mencoba meloncati pagar di timur tapi kamu tersangkut').
d :-
    playerPoint(R, C),
    NewC is C + 1,
    waterTilePoint(R, NewC),
    !, 
    write('Kamu enggak boleh nyebur ke sungai karena kamu tidak bisa berenang').
d :-
    state(S),
    S \= free, !,
    format('Kamu harus keluar dulu dari ~w agar bisa bergerak ke timur\n', [S]).
d :-
    playerPoint(R, C),
    NewC is C + 1,
    retractall(playerPoint(_, _)),
    asserta(playerPoint(R, NewC)),
    !,
    write('Kamu berhasil bergerak ke timur'), nl,
    cellCheck(R, NewC).

% pengecekan cell
cellCheck(R, C) :-
    housePoint(R, C),
    retractall(playerCell(_)),
    asserta(playerCell('H')),
    !,
    write('Kamu sekarang ada di rumah'), nl,
    write('Tulis house. untuk masuk ke rumah').
cellCheck(R, C) :-
    ranchPoint(R, C),
    retractall(playerCell(_)),
    asserta(playerCell('R')),
    !,
    write('Kamu sekarang ada di peternakan').
cellCheck(R, C) :-
    marketplacePoint(R, C),
    retractall(playerCell(_)),
    asserta(playerCell('M')),
    !,
    write('Kamu sekarang ada di pasar'), nl,
    write('Tulis marketplace. untuk masuk ke rumah').
cellCheck(R, C) :-
    questPoint(R, C),
    retractall(playerCell(_)),
    asserta(playerCell('Q')),
    !,
    write('Kamu sekarang ada di tempat pengambilan quest'), nl,
    write('Tulis quest. untuk masuk ke rumah').
cellCheck(R, C) :-
    waterTilePoint(Rw, Cw),
    (
        (Rw =:= R + 1, Cw =:= C);
        (Rw =:= R - 1, Cw =:= C);
        (Rw =:= R, Cw =:= C + 1);
        (Rw =:= R, Cw =:= C - 1)
    ),
    retractall(playerCell(_)),
    asserta(playerCell('o')),
    !,
    write('Kamu sekarang ada di sekitar danau').
cellCheck(R, C) :-
    diggedTilePoint(R, C),
    retractall(playerCell(_)),
    asserta(playerCell('=')),
    !,
    write('Kamu sekarang ada di tanah yang sedang digali').
cellCheck(R, C) :-
    potatoTilePoint(R, C),
    retractall(playerCell(_)),
    asserta(playerCell('p')),
    !,
    write('Kamu sekarang ada di kebun kentang').
cellCheck(R, C) :-
    carrotTilePoint(R, C),
    retractall(playerCell(_)),
    asserta(playerCell('c')),
    !,
    write('Kamu sekarang ada di kebun wortel').
cellCheck(R, C) :-
    tomatoTilePoint(R, C),
    retractall(playerCell(_)),
    asserta(playerCell('t')),
    !,
    write('Kamu sekarang ada di kebun tomat').
cellCheck(R, C) :-
    riceTilePoint(R, C),
    retractall(playerCell(_)),
    asserta(playerCell('r')),
    !,
    write('Kamu sekarang ada di sawah padi').
cellCheck(_, _) :-
    retractall(playerCell(_)),
    asserta(playerCell('-')).

teleport :-
  state(free),
  bisaTeleport(bisa),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  write('%                     ~Teleport Menu by peri gigi~                             %\n'),
  write('% 1. marketplace                                                               %\n'),
  write('% 2. quest                                                                     %\n'),
  write('% 3. ranching                                                                  %\n'),
  write('% 4. house                                                                     %\n'),
  write('% 5. waterTile                                                                 %\n'),
  write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
  nl, nl,
  write('Kamu mau teleport ke mana? '),
  read(Tujuan),
  (
    (
      (Tujuan = marketplace; Tujuan = 1), !,
      marketplacePoint(X, Y),
      retractall(playerCell(_)),
      retractall(playerPoint(_, _)),
      asserta(playerCell('M')),
      asserta(playerPoint(X, Y)),

      write('Kamu berhasil teleport ke marketplace\n')
    );
    (
      (Tujuan = quest; Tujuan = 2), !,
      questPoint(X, Y),
      retractall(playerCell(_)),
      retractall(playerPoint(_, _)),
      asserta(playerCell('Q')),
      asserta(playerPoint(X, Y)),

      write('Kamu berhasil teleport ke quest\n')
    );
    (
      (Tujuan = ranching; Tujuan = 3), !,
      ranchPoint(X, Y),
      retractall(playerCell(_)),
      retractall(playerPoint(_, _)),
      asserta(playerCell('R')),
      asserta(playerPoint(X, Y)),

      write('Kamu berhasil teleport ke ranching\n')
    );
    (
      (Tujuan = house; Tujuan = 4), !,
      housePoint(X, Y),
      retractall(playerCell(_)),
      retractall(playerPoint(_, _)),
      asserta(playerCell('H')),
      asserta(playerPoint(X, Y)),

      write('Kamu berhasil teleport ke house\n')
    );
    (
      (Tujuan = waterTile; Tujuan = 5),
      retractall(playerCell(_)),
      retractall(playerPoint(_, _)),
      asserta(playerCell('o')),
      asserta(playerPoint(6, 8)),

      write('Kamu berhasil teleport ke dekat water tile\n')
    );
    (
      write('Tidak ada portal di tempat pilihanmu, teleport dibatalkan.\n')
    )
  ).
teleport :-
  state(free),
  bisaTeleport(enggak),
  write('Kamu tidak mendapat kemampuan teleport').