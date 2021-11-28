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
    state(market),
    playerCell(C),
    C = ('M'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                              ~Market~                                             %\n'),
    write('% - buy          : membeli barang yang ada di pasar                                 %\n'),
    write('% - sell         : menjual barang yang kamu punya                                   %\n'),
    write('% - exitMarket   : keluar dari market                                               %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                          ~Kemampuan Item~                                         %\n'),
    write('%                           ~Item Farming~                                          %\n'),
    write('% 1. potato_seed         : Tumbuh dalam 3 hari, tiap seed menghasilkan 1-4 kentang  %\n'),
    write('% 2. carrot_seed         : Tumbuh dalam 6 hari, tiap seed menghasilkan 2-6 wortel   %\n'),
    write('% 3. tomato_seed         : Tumbuh dalam 2 hari, tiap seed menghasilkan 1-4 tomat    %\n'),
    write('% 4. rice_seed           : Tumbuh dalam 3 hari, tiap seed menghasilkan 3-6 padi     %\n'),
    write('% 5. potato              : Dapat diubah menjadi 2 seed kentang                      %\n'),
    write('% 6. carrot              : Dapat diubah menjadi 3 seed wortel                       %\n'),
    write('% 7. tomato              : Dapat diubah menjadi 3 seed tomat                        %\n'),
    write('% 8. rice                : Dapat diubah menjadi 4 seed padi                         %\n'),
    write('% 9. shovel              : Item diperlukan untuk dig tile                           %\n'),
    write('% 9. fertilizer          : Mempercepat pertumbuhan tanaman sebanyak 1 hari          %\n'),
    write('% 9. good_fertilizer     : Mempercepat pertumbuhan tanaman 50 % dari waktu tumbuh   %\n'),
    write('% 9. best_fertilizer     : Mempercepat pertumbuhan tanaman 75 % dari waktu tumbuh   %\n'),
    write('% 9. instant_fertilizer  : Menumbuhkan tanaman apapun sebanyak 1 hari               %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                           ~Item Fishing~                                          %\n'),
    write('% 1. lele        : Memiliki kemungkinan sebesar 50 % pada level 1 untuk ditangkap   %\n'),
    write('% 2. nila        : Memiliki kemungkinan sebesar 30 % pada level 1 untuk ditangkap   %\n'),
    write('% 3. gurame      : Memiliki kemungkinan sebesar 10 % pada level 1 untuk ditangkap.  %\n'),
    write('% 4. patin       : Memiliki kemungkinan sebesar 10 % pada level 1 untuk ditangkap.  %\n'),
    write('% 5. salmon      : Memiliki kemungkinan sebesar 8 % pada level 1 untuk ditangkap.   %\n'),
    write('% 6. tuna        : Memiliki kemungkinan sebesar 6 % pada level 1 untuk ditangkap.   %\n'),
    write('% 7. pari        : Memiliki kemungkinan sebesar 3 % pada level 1 untuk ditangkap.   %\n'),
    write('% 8. barracuda   : Memiliki kemungkinan sebesar 2 % pada level 1 untuk ditangkap.   %\n'),
    write('% 9. hiu         : Memiliki kemungkinan sebesar 1 % pada level 1 untuk ditangkap.   %\n'),
    write('% 10. normal_rod : Dibutuhkan untuk fishing ikan lele dan nila, tiap fishing        %\n'),
    write('%                  bertambah 10 fishing exp                                         %\n'),
    write('% 11. good_rod   : Dibutuhkan untuk fishing ikan lele, nila, gurame, dan patin,     %\n'),
    write('%                  tiap fishing bertambah 15 fishing exp                            %\n'),
    write('% 12. rare_rod   : Dibutuhkan untuk fishing ikan lele, nila, gurame, patin, salmon, %\n'),
    write('%                  dan tuna, tiap fishing bertambah 20 fishing exp                  %\n'),
    write('% 13. legend_rod : Dibutuhkan untuk fishing semua ikan terutama legendary fish      %\n'),
    write('%                  yaitu hiu dan barracuda, tiap fishing bertambah 25 fishing exp   %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),
    write('%                           ~Item Ranching~                                         %\n'),
    write('% 1. chicken : Dewasa dalam waktu 1 minggu, saat dewasa bertelur tiap 6 hari        %\n'),
    write('% 2. turkey  : Dewasa dalam waktu 2 minggu                                          %\n'),
    write('% 3. sheep   : Dewasa dalam waktu 3 minggu, saat dewasa wol bertumbuh tiap 7 hari   %\n'),
    write('% 4. cow     : Dewasa dalam waktu 4 minggu, saat dewasa susu dapat diperah tiap hari%\n'),
    write('% 5. egg     : Telur.                                                               %\n'),
    write('% 6. woll    : Woll.                                                                %\n'),
    write('% 7. milk    : Satu liter susu sapi.                                                %\n'),
    write('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n'),!.
help :-
    state(free),
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