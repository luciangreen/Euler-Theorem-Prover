:- begin_tests(decimal_terms).

:- use_module('../prolog/main').

test(decimal_constant_term) :-
    prove(sum(i,1,n,0.5), Result),
    result_closed_form(Result, n/2).

:- end_tests(decimal_terms).
