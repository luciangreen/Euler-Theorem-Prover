:- begin_tests(linear).

:- use_module('../prolog/main').

test(sum_first_n) :-
    prove(sum(i,1,n,i), Result),
    result_closed_form(Result, n*(n+1)/2).

test(sum_linear_combo) :-
    prove(sum(i,1,n,2*i+1), Result),
    result_closed_form(Result, n*(n+1)+n).

:- end_tests(linear).
