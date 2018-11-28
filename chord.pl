number(c, 0).
number(cs, 1).
number(d, 2).
number(ds, 3).
number(e, 4).
number(f, 5).
number(fs, 6).
number(g, 7).
number(gs, 8).
number(a, 9).
number(as, 10).
number(b, 11).

chord([S1, S2, S3], [S1, '']):-
    number(S1, Num1),
    number(S2, Num2),
    number(S3, Num3),
    dif(Num1, Num2, Dif12),
    dif(Num1, Num3, Dif13),
    Dif12 = 4,
    Dif13 = 7.
chord([S1, S2, S3], [S1, 'm']):-
    number(S1, Num1),
    number(S2, Num2),
    number(S3, Num3),
    dif(Num1, Num2, Dif12),
    dif(Num1, Num3, Dif13),
    Dif12 = 3,
    Dif13 = 7.
chord([S1, S2, S3, S4], [S1, '7']):-
    number(S1, Num1),
    number(S2, Num2),
    number(S3, Num3),
    number(S4, Num4),
    dif(Num1, Num2, Dif12),
    dif(Num1, Num3, Dif13),
    dif(Num1, Num4, Dif14),
    Dif12 = 4,
    Dif13 = 7,
    Dif14 = 10.
chord([S1, S2, S3, S4], [S1, 'm7']):-
    number(S1, Num1),
    number(S2, Num2),
    number(S3, Num3),
    number(S4, Num4),
    dif(Num1, Num2, Dif12),
    dif(Num1, Num3, Dif13),
    dif(Num1, Num4, Dif14),
    Dif12 = 3,
    Dif13 = 7,
    Dif14 = 11.
chord([S1, S2, S3], [S1, 'sus4']):-
    number(S1, Num1),
    number(S2, Num2),
    number(S3, Num3),
    dif(Num1, Num2, Dif12),
    dif(Num1, Num3, Dif13),
    Dif12 = 5,
    Dif13 = 7.
chord([S1, S2, S3], [S1, 'aug']):-
    number(S1, Num1),
    number(S2, Num2),
    number(S3, Num3),
    dif(Num1, Num2, Dif12),
    dif(Num1, Num3, Dif13),
    Dif12 = 4,
    Dif13 = 8.
chord([S1, S2, S3, S4], [S1, 'aug7']):-
    number(S1, Num1),
    number(S2, Num2),
    number(S3, Num3),
    number(S4, Num4),
    dif(Num1, Num2, Dif12),
    dif(Num1, Num3, Dif13),
    dif(Num1, Num4, Dif14),
    Dif12 = 4,
    Dif13 = 8,
    Dif14 = 10.
chord([S1, S2, S3], [S1, 'dim']):-
    number(S1, Num1),
    number(S2, Num2),
    number(S3, Num3),
    dif(Num1, Num2, Dif12),
    dif(Num1, Num3, Dif13),
    Dif12 = 3,
    Dif13 = 6.
chord([S1, S2, S3, S4], [S1, 'dim7']):-
    number(S1, Num1),
    number(S2, Num2),
    number(S3, Num3),
    number(S4, Num4),
    dif(Num1, Num2, Dif12),
    dif(Num1, Num3, Dif13),
    dif(Num1, Num4, Dif14),
    Dif12 = 3,
    Dif13 = 6,
    Dif14 = 9.

diatonic_scale([Sound, _Option]):- number(Sound, 0).
diatonic_scale([Sound, _Option]):- number(Sound, 2).
diatonic_scale([Sound, _Option]):- number(Sound, 4).
diatonic_scale([Sound, _Option]):- number(Sound, 5).
diatonic_scale([Sound, _Option]):- number(Sound, 7).
diatonic_scale([Sound, _Option]):- number(Sound, 9).
diatonic_scale([Sound, _Option]):- number(Sound, 11).

agency(Chord, Agent):-
    diatonic_scale(Agent),
    chord(SoundC, Chord),
    chord(SoundA, Agent),
    common(SoundC, SoundA),
    Chord \== Agent.

tonic([c]).
tonic(Chord):- agency([c], Chord).

subdominant([f]).
subdominant(Chord):- agency([f], Chord).

dominant([g]).
dominant(Chord):- agency([g], Chord).

good(X, _):- tonic(X).
good(X, Y):-
    subdominant(X),
    dominant(Y).
good(X, Y):-
    subdominant(X),
    tonic(Y).
good(X, Y):-
    dominant(X),
    tonic(Y).

complete([First, Last]) :-
    good(First, Last),
    tonic(Last),
    !.
complete([First, Second | Other]):-
    good(First, Second),
    add(Second, Other, NextList),
    complete(NextList).

agency_concat(Chord, Output):-
    agency(Chord, Agent),
    atomic_list_concat(Agent, Output).
agency_list(Chord, List):-
    findall(Agent, agency_concat(Chord, Agent), Agents),
    atomic_list_concat(Agents, ", ", List).

add(X, List, [X|List]).

dif(X, Y, Dif):- Dif is Y - X.
dif(X, Y, Dif):- Dif is Y + 12 - X.

common([X, X1|_], [X, X1|_]):- !.
common([_|X], Y):- common(X, Y), !.
common(X, [_|Y]):- common(X, Y), !.
