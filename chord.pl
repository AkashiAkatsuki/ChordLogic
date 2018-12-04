scale_list([c, cs, d, ds, e, f, fs, g, gs, a, as, b]).

chord([S1, S2, S3], [S1, '']):-
    Dif12 = 4,
    Dif13 = 7,
    scale_dif(S1, S2, Dif12),
    scale_dif(S1, S3, Dif13).
chord([S1, S2, S3], [S1, 'm']):-
    Dif12 = 3,
    Dif13 = 7,
    scale_dif(S1, S2, Dif12),
    scale_dif(S1, S3, Dif13).
chord([S1, S2, S3, S4], [S1, '7']):-
    Dif12 = 4,
    Dif13 = 7,
    Dif14 = 10,
    scale_dif(S1, S2, Dif12),
    scale_dif(S1, S3, Dif13),
    scale_dif(S1, S4, Dif14).
chord([S1, S2, S3, S4], [S1, 'm7']):-
    Dif12 = 3,
    Dif13 = 7,
    Dif14 = 11,
    scale_dif(S1, S2, Dif12),
    scale_dif(S1, S3, Dif13),
    scale_dif(S1, S4, Dif14).
chord([S1, S2, S3], [S1, 'sus4']):-
    Dif12 = 5,
    Dif13 = 7,
    scale_dif(S1, S2, Dif12),
    scale_dif(S1, S3, Dif13).
chord([S1, S2, S3], [S1, 'aug']):-
    Dif12 = 4,
    Dif13 = 8,
    scale_dif(S1, S2, Dif12),
    scale_dif(S1, S3, Dif13).
chord([S1, S2, S3, S4], [S1, 'aug7']):-
    Dif12 = 4,
    Dif13 = 8,
    Dif14 = 10,
    scale_dif(S1, S2, Dif12),
    scale_dif(S1, S3, Dif13),
    scale_dif(S1, S4, Dif14).
chord([S1, S2, S3], [S1, 'dim']):-
    Dif12 = 3,
    Dif13 = 6,
    scale_dif(S1, S2, Dif12),
    scale_dif(S1, S3, Dif13).
chord([S1, S2, S3, S4], [S1, 'dim7']):-
    Dif12 = 3,
    Dif13 = 6,
    Dif14 = 9,
    scale_dif(S1, S2, Dif12),
    scale_dif(S1, S3, Dif13),
    scale_dif(S1, S4, Dif14).

diatonic([Sound, _Option]):- scale_list(ScaleList), nth0(0, ScaleList, Sound).
diatonic([Sound, _Option]):- scale_list(ScaleList), nth0(2, ScaleList, Sound).
diatonic([Sound, _Option]):- scale_list(ScaleList), nth0(4, ScaleList, Sound).
diatonic([Sound, _Option]):- scale_list(ScaleList), nth0(5, ScaleList, Sound).
diatonic([Sound, _Option]):- scale_list(ScaleList), nth0(7, ScaleList, Sound).
diatonic([Sound, _Option]):- scale_list(ScaleList), nth0(9, ScaleList, Sound).
diatonic([Sound, _Option]):- scale_list(ScaleList), nth0(11, ScaleList, Sound).

agency(Chord, Agent):-
    diatonic(Agent),
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

scale_dif(X, Y, Dif):-
    scale_list(Scale),
    append(Scale, Scale, ScaleList),
    count_dif(X, Y, ScaleList, Dif).

count_dif(Y, [Y | _], 0).
count_dif(Y, [_ | L], Num) :- count_dif(Y, L, Num2), Num is Num2 + 1.
count_dif(X, Y, [X | L], Num):- count_dif(Y, L, Num2), Num is Num2 + 1, !.
count_dif(X, Y, [_ | L], Num) :- count_dif(X, Y, L, Num), !.

common([X, X1|_], [X, X1|_]):- !.
common([_|X], Y):- common(X, Y), !.
common(X, [_|Y]):- common(X, Y), !.
