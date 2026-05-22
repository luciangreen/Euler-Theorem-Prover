:- begin_tests(stage2).

:- use_module('../prolog/main').

test(sum_fifth_powers) :-
    prove(sum(i,1,n,i^5), Result),
    result_closed_form(Result, n^2*(n+1)^2*(2*n^2+2*n-1)/12).

test(algorithm_mode_named_method) :-
    prove_algorithm(sum_squares_by_known_formula, Result),
    Result = theorem(method(known_formula_expansion), _, _, _, _).

test(algorithm_projection_api) :-
    prove_algorithm(sum_squares_by_euler_maclaurin, ClosedForm, Steps),
    ClosedForm = n*(n+1)*(2*n+1)/6,
    member(apply_euler_maclaurin_corrections, Steps).

:- end_tests(stage2).
