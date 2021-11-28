house :-
    state(not_started),!,
    write('Permainan belum dimulai').

house :-
    state(free),
    playerCell(X),
    X \= 'H',!,
    write('Anda harus berada di house terlebih dahulu').

house :-
    state(house),
    playerCell('H'),!,
    write('kamu sudah ada di dalam rumah').

house :-
    state(free),
    playerCell('H'),
    setState(house),!,
    write('Selama datang dirumah !!! \n'),
    write('apa yang ingin anda lakukan : \n'),
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
        write('masukkan command "sleep." atau "exitHouse."')
    ).

sleep :-
    state(house),
    write('Anda mulai menuju kasur dan mulai menutup mata, Anda pun tertidur dengan lelap\n'),
    addDays, days(X),
    write('sekarang adalah hari ke -'),write(' '),write(X),nl,
    write('semoga hari anda menyenangkan').

exitHouse :-
    setState(free), !,
    write('Anda telah berada di luar rumah').
    


