% file untuk belajar prolog

% deklarasi predikat dinamik 'nama' dengan satu term
:- dynamic(nama/1).
% predikat dinamik dapat ditambah/dikurangi selama program berjalan
% asserta(X) : tambah fakta di paling atas
% assertz(X) : tambah fakta di paling bawah
% retract(X) : hapus fakta atau klausa X
% retractall(X) : hapus semua fakta atau klausa

nama(boa_hancock).

halo :-
    write('sapa namamu sahabat?'), nl,
    read(Nama), % baca input
    asserta(nama(Nama)), % menambah fakta nama(Nama) di urutan teratas
    write('halo'),
    tab(1), % memberi spasi sebanyak satu
    write(Nama).

hapusNama(X) :-
    retract(nama(X)).

hapusSemuaNama :-
    retractall(nama(_)).

tampilkanNama :-
    listing(nama).

keluar :-
    halt. % keluar dari program prolog

% mirip loop
% | ?- printPagar(10).
% ##########
printPagar(X) :-
    forall(between(1, X, _NumberAntara1danX), write('#')).

% command yang mungkin berguna
% listing(<predikat>) : menampilkan keseluruhan fakta pada predikat
% ! : cuts seteleh dilalu akan menghentikan proses backtracking
% fail : selalu salah, biasanya digabung dengan cuts --> !, fail.