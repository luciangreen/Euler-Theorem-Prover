:- begin_tests(stage13).

:- use_module('../prolog/main').

test(sum_first_n) :-
    prove(sum(i,1,n,i), Result),
    result_closed_form(Result, n*(n+1)/2).

test(sum_squares) :-
    prove(sum(i,1,n,i^2), Result),
    result_closed_form(Result, n*(n+1)*(2*n+1)/6).

test(sum_cubes) :-
    prove(sum(i,1,n,i^3), Result),
    result_closed_form(Result, (n*(n+1)/2)^2).

test(shifted_square) :-
    prove(sum(i,1,n,(i+2)^2), Result),
    result_closed_form(Result,
      n*(n+1)*(2*n+1)/6 + 2*n*(n+1) + 4*n).

test(cube_plus_half) :-
    prove(sum(i,1,n,i^3 + 0.5), Result),
    result_closed_form(Result, (n*(n+1)/2)^2 + n/2).

:- end_tests(stage13).
