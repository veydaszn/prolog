% ===============================================
% FAMILY EXPERT SYSTEM – INFERENCE OF RELATIONSHIPS
% Author: AI Assistant
% Date: October 30, 2025
% Purpose: Define family facts and infer new relationships
% ===============================================

% ------------------- FACTS -------------------

% Gender
male(john).
male(bob).
male(tom).
male(peter).
male(mike).

female(mary).
female(jean).
female(ann).
female(sue).
female(lisa).

% Parent relationships (X is parent of Y)
parent(john, bob).
parent(john, ann).
parent(mary, bob).
parent(mary, ann).

parent(bob, tom).
parent(bob, sue).
parent(ann, peter).
parent(ann, lisa).

parent(tom, mike).

% ------------------- INFERRED RELATIONSHIPS -------------------

% 1. Grandparent
grandparent(GP, GC) :-
    parent(GP, P),
    parent(P, GC).

% 2. Grandfather / Grandmother
grandfather(GF, GC) :- grandparent(GF, GC), male(GF).
grandmother(GM, GC) :- grandparent(GM, GC), female(GM).

% 3. Sibling (same parents)
sibling(X, Y) :-
    parent(P, X),
    parent(P, Y),
    X \= Y.

% 4. Brother / Sister
brother(B, Person) :- sibling(B, Person), male(B).
sister(S, Person) :- sibling(S, Person), female(S).

% 5. Aunt / Uncle
aunt(A, Person) :-
    parent(P, Person),
    sister(A, P).

uncle(U, Person) :-
    parent(P, Person),
    brother(U, P).

% 6. Cousin
cousin(C1, C2) :-
    parent(P1, C1),
    parent(P2, C2),
    sibling(P1, P2),
    C1 \= C2.

% 7. Ancestor (recursive)
ancestor(A, D) :-
    parent(A, D).
ancestor(A, D) :-
    parent(A, X),
    ancestor(X, D).

% 8. Descendant
descendant(D, A) :- ancestor(A, D).

% 9. Niece / Nephew
niece(N, Person) :-
    aunt(Person, N) ; uncle(Person, N),
    female(N).

nephew(N, Person) :-
    aunt(Person, N) ; uncle(Person, N),
    male(N).

% 10. In-law relationships
spouse(X, Y) :- parent(X, Child), parent(Y, Child), X \= Y.
married(X, Y) :- spouse(X, Y).

parent_in_law(PIL, Person) :-
    spouse(S, Person),
    parent(PIL, S).

son_in_law(SIL, Person) :-
    parent(Person, Spouse),
    spouse(Spouse, SIL),
    male(SIL).

daughter_in_law(DIL, Person) :-
    parent(Person, Spouse),
    spouse(Spouse, DIL),
    female(DIL).

% ------------------- UTILITY PREDICATES -------------------

% Display all known relationships for a person
relationships(Person) :-
    format('~n=== Relationships for ~w ===~n', [Person]),
    (   grandfather(GF, Person) -> format('Grandfather: ~w~n', [GF]) ; true ),
    (   grandmother(GM, Person) -> format('Grandmother: ~w~n', [GM]) ; true ),
    (   parent(P, Person) -> format('Parent: ~w~n', [P]) ; true ),
    (   sibling(S, Person) -> format('Sibling: ~w~n', [S]) ; true ),
    (   brother(B, Person) -> format('Brother: ~w~n', [B]) ; true ),
    (   sister(Si, Person) -> format('Sister: ~w~n', [Si]) ; true ),
    (   aunt(A, Person) -> format('Aunt: ~w~n', [A]) ; true ),
    (   uncle(U, Person) -> format('Uncle: ~w~n', [U]) ; true ),
    (   cousin(C, Person) -> format('Cousin: ~w~n', [C]) ; true ),
    (   ancestor(Anc, Person), Anc \= Person -> format('Ancestor: ~w~n', [Anc]) ; true ),
    (   niece(N, Person) -> format('Niece: ~w~n', [N]) ; true ),
    (   nephew(Nep, Person) -> format('Nephew: ~w~n', [Nep]) ; true ),
    nl.
