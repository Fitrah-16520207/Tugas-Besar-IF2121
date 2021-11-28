mainMenu :-
    write('   _   _                           _   \n'),
    write('  | | | | __ _ _ ____   _____  ___| |_ \n'),
    write('  | |_| |/ _` | \'__\\ \\ / / _ \\/ __| __|\n'),
    write('  |  _  | (_| | |   \\ V /  __/\\__ \\ |_ \n'),
    write('  |_| |_|\\__,_|_|    \\_/ \\___||___/\\__|\n'),
    nl,
    write('Harvest Star!!!'),
    nl,
    write('Let`s play and pay our debts together!'),
    nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Harvest Star~                                  %\n'),
    write('% 1. start  : untuk memulai petualanganmu                                      %\n'),
    write('% 2. map    : menampilkan peta                                                 %\n'),
    write('% 3. status : menampilkan kondisimu terkini                                    %\n'),
    write('% 4. w      : gerak ke utara 1 langkah                                         %\n'),
    write('% 5. s      : gerak ke selatan 1 langkah                                       %\n'),
    write('% 6. d      : gerak ke ke timur 1 langkah                                      %\n'),
    write('% 7. a      : gerak ke barat 1 langkah                                         %\n'),
    write('% 8. help   : menampilkan segala bantuan                                       %\n'),
    write('% 9. quit   : keluar dari game                                                 %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n').

help :-
    state(free),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                           ~Perintah Permainan~                                    %\n'),
    write('% - map          : menampilkan peta                                                 %\n'),
    write('% - status       : menampilkan kondisimu terkini                                    %\n'),
    write('% - w            : gerak ke utara 1 langkah                                         %\n'),
    write('% - s            : gerak ke selatan 1 langkah                                       %\n'),
    write('% - d            : gerak ke ke timur 1 langkah                                      %\n'),
    write('% - a            : gerak ke barat 1 langkah                                         %\n'),
    write('% - help         : menampilkan segala bantuan                                       %\n'),
    write('% - quit         : keluar dari game                                                 %\n'),
    write('% - inventory    : menampilkan barang dan peralatan yang kamu simpan                %\n'),
    write('% - quest        : menampilkan quest yang tersedia untuk kamu                       %\n'),
    write('% - dig          : menggali tanah yang berada di bawahmu                            %\n'),
    write('% - plant        : menanam tanaman di tanah yang sudah kamu gali                    %\n'),
    write('% - fish         : memancing ikan ketika kamu berada di sekitar tile air            %\n'),
    write('% - ranch        : menampilkan hewan ternak yang kamu punya                         %\n'),
    write('% - marketplace  : menjual atau membeli barang di pasar ketika kamu berada di tile M%\n'),
    write('% - house        : masuk ke rumah ketika kamu berada di tile rumah                  %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    nl,
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                           ~Tujuan Permainan~                                      %\n'),
    write('%Kamu dinyatakan menang jika kamu berhasil mengumpulkan uang sebesar 20000 gold     %\n'),
    write('%dalam jangka waktu 1 tahun.                                                        %\n'),
    write('%Jika gagal mengumpulkan 20000 gold dalam satu tahun maka kamu dinyatakan kalah     %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Good Luck%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),fail,nl.
help :- 
    state(not_started),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Harvest Star~                                  %\n'),
    write('% 1. start  : untuk memulai petualanganmu                                      %\n'),
    write('% 2. help   : menampilkan segala bantuan                                       %\n'),
    write('% 3. quit   : keluar dari game                                                 %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),!.
help :-
    stateMarket('di dalam'),
    playerCell(C),
    C = ('M'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Market~                                             %\n'),
    write('% - buy          : membeli barang yang ada di pasar                                 %\n'),
    write('% - sell         : menjual barang yang kamu punya                                   %\n'),
    write('% - exitMarket   : keluar dari market                                               %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),!.
help :-
    stateMarket('di luar'),
    playerCell(C),
    C = ('M'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Market~                                             %\n'),
    write('% - marketplace  : masuk ke dalam market                                            %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),!.
help:-
    playerPoint(R, C),
    NewR is R + 1,waterTilePoint(NewR, C),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Fishing~                                            %\n'),
    write('% - fish  : memancing ikan di sekitar water tile                                    %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),fail.
help:-
    playerPoint(R, C),
    NewR is R - 1,waterTilePoint(NewR, C),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Fishing~                                            %\n'),
    write('% - fish  : memancing ikan di sekitar water tile                                    %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),fail.
help:-
    playerPoint(R, C),
    NewC is C + 1,waterTilePoint(R, NewC),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Fishing~                                            %\n'),
    write('% - fish  : memancing ikan di sekitar water tile                                    %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),fail.
help:-
    playerPoint(R, C),
    NewC is C - 1,waterTilePoint(R, NewC),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Fishing~                                            %\n'),
    write('% - fish  : memancing ikan di sekitar water tile                                    %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),fail.
help :-
    playerCell(C),
    C = ('c'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Farming~                                            %\n'),
    write('% - harvest       : panen tanaman yang kamu tanam                                   %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),!.
help :-
    playerCell(C),
    C = ('p'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Farming~                                            %\n'),
    write('% - harvest       : panen tanaman yang kamu tanam                                   %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),!.
help :-
    playerCell(C),
    C = ('t'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Farming~                                            %\n'),
    write('% - harvest       : panen tanaman yang kamu tanam                                   %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),!.
help :-
    playerCell(C),
    C = ('r'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Farming~                                            %\n'),
    write('% - harvest       : panen tanaman yang kamu tanam                                   %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),!.

help :-
    playerCell(C),
    C = ('='),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Farming~                                            %\n'),
    write('% - dig          : menggali tanah agar bisa ditanam                                 %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),!.

help :-
    playerCell(C),
    C = ('-'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Farming~                                            %\n'),
    write('% - plant          : menanam benih tumbuhan yang kamu punya                         %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),!.