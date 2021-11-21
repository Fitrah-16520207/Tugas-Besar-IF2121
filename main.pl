









startGame :-
    mainMenu,
    nl,
    read(Command),
    ((
        Command = start
        start
    );
    (
        Command = map
        map
    );
    (
        Command = status
        status
    );
    (
        Command = w
        move_w
    );
    (
        Command = s
        move_s
    );
    (
        Command = d
        move_d
    );
    (
        Command = a
        move_a
    );
    (
        Command = help
        help
    );
    (
        Command = quit
        quit
    )
    )

start :-
    reset,
    write('Welcome to Harvest Star. Choose your job'),
    read(Job),
    setJob(Job).

quit :-
    halt.


