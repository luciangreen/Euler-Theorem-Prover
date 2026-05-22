:- begin_tests(decimal_terms).

:- use_module('../prolog/main').

test(decimal_constant_term) :-
    prove(sum(i,1,n,0.5), Result),
    result_closed_form(Result, 0.5*n).

:- end_tests(decimal_terms).
