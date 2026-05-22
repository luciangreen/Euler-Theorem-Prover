:- begin_tests(euler_maclaurin).

:- use_module('../prolog/euler_maclaurin').
:- use_module('../prolog/explain').

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
    First = proof_step(
        formal(equals(sum(i,1,n,i), integral(x,0,n,x) + (n+0)/2)),
        explanation("Euler-Maclaurin turns the staircase sum into an area plus a small endpoint correction.")
    ).

test(prove_uses_structured_steps) :-
    prove(sum_squares, Steps),
    forall(
        member(Step, Steps),
        Step = proof_step(formal(_), explanation(_))
    ).

test(proof_step_lookup) :-
    proof_step(
        formal(equals(integral(x,0,n,x), n^2/2)),
        explanation("The area under y=x from 0 to n is a triangle with area n squared over 2.")
    ).

:- end_tests(euler_maclaurin).
