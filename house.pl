house :-
    state(not_started),!,
    write('Permainan belum dimulai').

house :-
    state(free),
    playerCell(X),
    X \= 'H',!,
    write('Kamu harus berada di house terlebih dahulu').

house :-
    state(house),
    playerCell('H'),!,
    write('Kamu sudah ada di dalam rumah').

house :-
    state(free),
    playerCell('H'),
    setState(house),!,
    write('Selama datang dirumah !!! \n'),
    write('Apa yang ingin kamu lakukan : \n'),
    write('1. sleep\n'),
    write('2. exitHouse\n'),
    read(Pilihan),
    ((
        Pilihan = ('sleep'),
        sleep
    );
    (
        Pilihan = ('exitHouse'),
        exitHouse
    );
        write('Masukkan command "sleep." atau "exitHouse."')
    ).

sleep :-
    state(house),
    write('Kamu mulai menuju kasur dan mulai menutup mata, kamu pun tertidur dengan lelap\n'),
    addDays, days(X),
    write('Sekarang adalah hari ke -'),write(' '),write(X),nl,
    write('Semoga hari kamu menyenangkan').

exitHouse :-
    setState(free), !,
    write('Kamu telah berada di luar rumah').
    


