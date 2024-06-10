:- use_module(library(clpfd)). % Constraint Logic Programming over Finite Domains
:- use_module(library(lists)).
:- use_module(library(apply)).

sudoku(Rows) :-
    length(Rows, 9),
    maplist(same_length(Rows), Rows),
    append(Rows, Vs), Vs ins 1..9,
    maplist(all_distinct, Rows),
    transpose(Rows, Columns),
    maplist(all_distinct, Columns),
    Rows = [As,Bs,Cs,Ds,Es,Fs,Gs,Hs,Is],
    blocks(As, Bs, Cs),
    blocks(Ds, Es, Fs),
    blocks(Gs, Hs, Is).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
    all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
    blocks(Ns1, Ns2, Ns3).

problem(1, [[5,3,_,_,7,_,_,_,_],
            [6,_,_,1,9,5,_,_,_],
            [_,9,8,_,_,_,_,6,_],
            [8,_,_,_,6,_,_,_,3],
            [4,_,_,8,_,3,_,_,1],
            [7,_,_,_,2,_,_,_,6],
            [_,6,_,_,_,_,2,8,_],
            [_,_,_,4,1,9,_,_,5],
            [_,_,_,_,8,_,_,7,9]]).

show(Options, Rows) :-
    portray_clause('Solving Sudoku with options:', Options),
    portray_clause(Rows),
    maplist(labeling(Options), Rows),
    portray_clause(Rows).

label_and_display(Rows) :-
    maplist(label, Rows),
    maplist(portray_clause, Rows).
