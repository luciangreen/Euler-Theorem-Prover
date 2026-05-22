:- begin_tests(shifted_polynomials).

:- use_module('../prolog/main').

test(quadratic_polynomial) :-
    prove(sum(i,1,n,3*i^2 + 2*i + 1), Result),
    result_closed_form(Result,
      3*(n*(n+1)*(2*n+1)/6) + n*(n+1) + n).

:- end_tests(shifted_polynomials).
