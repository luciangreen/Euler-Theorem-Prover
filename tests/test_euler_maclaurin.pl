:- begin_tests(euler_maclaurin).

:- use_module('../prolog/euler_maclaurin').

test(euler_maclaurin_linear) :-
    euler_maclaurin(x, 0, n, n*(n+1)/2).

test(prove_sum_first_n) :-
    prove(sum_first_n, Steps),
    length(Steps, 5).

test(prove_sum_squares) :-
    prove(sum_squares, Steps),
    length(Steps, 5).

test(prove_sum_cubes) :-
    prove(sum_cubes, Steps),
    length(Steps, 4).

test(prove_first_step) :-
    prove(sum_first_n, [First|_]),
    First = "Use Euler-Maclaurin to connect the sum to an integral.".

:- end_tests(euler_maclaurin).
