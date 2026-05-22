:- begin_tests(squares).

:- use_module('../prolog/main').

test(sum_squares) :-
    prove(sum(i,1,n,i^2), Result),
    result_closed_form(Result, n*(n+1)*(2*n+1)/6).

test(shifted_square) :-
    prove(sum(i,1,n,(i+2)^2), Result),
    result_closed_form(Result,
      n*(n+1)*(2*n+1)/6 + 2*n*(n+1) + 4*n).

:- end_tests(squares).
