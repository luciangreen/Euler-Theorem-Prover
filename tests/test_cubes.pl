:- begin_tests(cubes).

:- use_module('../prolog/main').

test(sum_cubes) :-
    prove(sum(i,1,n,i^3), Result),
    result_closed_form(Result, (n*(n+1)/2)^2).

test(cube_plus_half) :-
    prove(sum(i,1,n,i^3 + 0.5), Result),
    result_closed_form(Result, (n*(n+1)/2)^2 + n/2).

:- end_tests(cubes).
