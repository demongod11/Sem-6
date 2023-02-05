countdown(N):-
    writeln(N),
    N1 is N-1,
    countdown(N1).

countdown(0).