:- begin_tests(sums).

:- use_module('../prolog/sums').

test(sum_first_n) :-
    closed_form(sum(i,1,n,i), n*(n+1)/2).

test(sum_squares) :-
    closed_form(sum(i,1,n,i^2), n*(n+1)*(2*n+1)/6).

test(sum_cubes) :-
    closed_form(sum(i,1,n,i^3), (n*(n+1)/2)^2).

test(theorem_sum_first_n) :-
    theorem(sum_first_n, equals(sum(i,1,n,i), n*(n+1)/2)).

test(theorem_sum_squares) :-
    theorem(sum_squares, equals(sum(i,1,n,i^2), n*(n+1)*(2*n+1)/6)).

test(theorem_sum_cubes) :-
    theorem(sum_cubes, equals(sum(i,1,n,i^3), (n*(n+1)/2)^2)).

test(derive_sum_power_1) :-
    derive_sum_power(1, n*(n+1)/2).

test(derive_sum_power_2) :-
    derive_sum_power(2, n*(n+1)*(2*n+1)/6).

test(derive_sum_power_3) :-
    derive_sum_power(3, (n*(n+1)/2)^2).

:- end_tests(sums).

:- begin_tests(euler_sums).

:- use_module('../prolog/sums').

test(sum_first_n) :-
    closed_form(sum(i,1,n,i), n*(n+1)/2).

test(sum_squares) :-
    closed_form(sum(i,1,n,i^2), n*(n+1)*(2*n+1)/6).

test(sum_cubes) :-
    closed_form(sum(i,1,n,i^3), (n*(n+1)/2)^2).

:- end_tests(euler_sums).
