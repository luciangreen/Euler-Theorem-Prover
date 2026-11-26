:- use_module('../prolog/main').
:- use_module('../prolog/em_derivation').
:- use_module('../prolog/euler_maclaurin').

:- begin_tests(em_derivation).

value(X, _, X) :- number(X), !.
value(n, N, N) :- !.
value(A+B, N, V) :- !, value(A, N, VA), value(B, N, VB), V is VA + VB.
value(A-B, N, V) :- !, value(A, N, VA), value(B, N, VB), V is VA - VB.
value(A*B, N, V) :- !, value(A, N, VA), value(B, N, VB), V is VA * VB.
value(A/B, N, V) :- !, value(A, N, VA), value(B, N, VB), V is VA / VB.
value(A^B, N, V) :- !, value(A, N, VA), value(B, N, VB), V is VA ** VB.

derivation_value(euler_maclaurin(_, integral(I), endpoint(E), corrections(Cs)), N, V) :-
    value(I, N, VI), value(E, N, VE),
    foldl([C, A0, A1]>>(value(C, N, VC), A1 is A0 + VC), Cs, 0, VC),
    V is VI + VE + VC.

test(bernoulli_numbers) :-
    findall(B, (between(0, 8, M), bernoulli(M, B)), Bs),
    assertion(Bs == [r(1,1), r(-1,2), r(1,6), r(0,1), r(-1,30), r(0,1), r(1,42), r(0,1), r(-1,30)]).

% The computed Euler-Maclaurin parts give the same values as the table of
% closed forms for powers 1 to 5, so the table is checked, not assumed.
test(derivation_matches_table) :-
    forall(between(1, 5, P),
           ( euler_maclaurin_derivation(P, n, D),
             euler_sum(i^P, i, 1, n, Closed),
             forall(between(1, 12, N),
                    ( derivation_value(D, N, V1), value(Closed, N, V2),
                      abs(V1 - V2) < 1.0e-6 )) )).

test(higher_powers_by_computation) :-
    forall(member(P, [6, 7, 9]),
           ( prove(sum(i, 1, n, i^P), theorem(_, closed_form(F), _, _, _)),
             forall(between(1, 10, N),
                    ( value(F, N, V), aggregate_all(sum(I^P), between(1, N, I), S),
                      abs(V - S) < 1.0e-6 )) )).

test(proof_shows_computed_parts) :-
    prove(sum(i, 1, n, i^2), theorem(_, _, proof_steps(Steps), _, _)),
    assertion(memberchk(apply_euler_maclaurin_corrections, Steps)),
    assertion(memberchk(euler_maclaurin_terms([euler_maclaurin(power(2), integral(n^3/3), endpoint(n^2/2), corrections([n/6]))]), Steps)).

test(sum_from_zero) :-
    prove(sum(i, 0, n, i), theorem(_, closed_form(F), _, _, _)),
    assertion(F == n*(n+1)/2).

test(sum_from_three) :-
    prove(sum(i, 3, n, i), theorem(_, closed_form(F), _, _, _)),
    forall(between(3, 9, N), ( value(F, N, V), aggregate_all(sum(I), between(3, N, I), S), V =:= S )).

test(fixed_limits) :-
    prove(sum(i, 1, 10, i), theorem(_, closed_form(55), _, _, _)),
    prove(sum(i, 2, 5, i^2), theorem(_, closed_form(54), _, _, _)).

test(constant_from_zero) :-
    prove(sum(i, 0, n, 1), theorem(_, closed_form(F), _, _, _)),
    assertion(F == n+1).

:- end_tests(em_derivation).
