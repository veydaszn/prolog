% ===============================================
% FAMILY EXPERT SYSTEM – REPORT
% This file documents facts, rules, queries, and outputs
% Load with: ?- [family_report].
% ===============================================

:- [family_expert_system].  % Load the main system

report :-
    write('========================================'), nl,
    write('   FAMILY EXPERT SYSTEM – FULL REPORT'), nl,
    write('========================================'), nl, nl,

    section('1. DEFINED FACTS'),
    list_facts,

    section('2. INFERRED RULES'),
    list_rules,

    section('3. SAMPLE QUERIES & OUTPUTS'),
    run_queries,

    section('4. FULL RELATIONSHIPS FOR KEY PEOPLE'),
    full_relationships,

    nl, write('*** REPORT COMPLETE ***'), nl.

% --- Helper: Print section header ---
section(Title) :-
    format('~n~n--- ~w ---~n', [Title]).

% --- 1. List all facts ---
list_facts :-
    write('Gender Facts:~n'),
    forall(male(X), format('  male(~w).~n', [X])),
    forall(female(X), format('  female(~w).~n', [X])),
    nl,
    write('Parent Facts:~n'),
    forall(parent(P, C), format('  parent(~w, ~w).~n', [P, C])).

% --- 2. List key inference rules ---
list_rules :-
    write('Key Inference Rules:~n'),
    write('  grandparent(GP, GC) :- parent(GP, P), parent(P, GC).~n'),
    write('  grandfather(GF, GC) :- grandparent(GF, GC), male(GF).~n'),
    write('  grandmother(GM, GC) :- grandparent(GM, GC), female(GM).~n'),
    write('  sibling(X, Y) :- parent(P, X), parent(P, Y), X \\= Y.~n'),
    write('  cousin(C1, C2) :- parent(P1, C1), parent(P2, C2), sibling(P1, P2).~n'),
    write('  ancestor(A, D) :- parent(A, D).~n'),
    write('  ancestor(A, D) :- parent(A, X), ancestor(X, D).~n'),
    write('  ... (and more – see family_expert_system.pl)~n').

% --- 3. Run sample queries ---
run_queries :-
    nl, write('Query 1: Who is the grandmother of mary?~n'),
    (grandmother(GM, mary) -> format('  grandmother(~w, mary).~n', [GM]) ; write('  None found.~n')),

    nl, write('Query 2: Who are the cousins of tom?~n'),
    (cousin(C, tom) -> format('  cousin(~w, tom).~n', [C]) ; write('  None found.~n')),

    nl, write('Query 3: Who are the uncles of peter?~n'),
    (uncle(U, peter) -> format('  uncle(~w, peter).~n', [U]) ; write('  None found.~n')),

    nl, write('Query 4: Ancestors of mike?~n'),
    (ancestor(A, mike) -> format('  ancestor(~w, mike).~n', [A]) ; write('  None found.~n')).

% --- 4. Full relationships ---
full_relationships :-
    nl, write('Full relationships for selected people:~n'),
    relationships(tom),
    relationships(peter),
    relationships(sue).
