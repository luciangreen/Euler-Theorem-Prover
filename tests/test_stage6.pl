:- begin_tests(stage6).

:- use_module('../prolog/main').

test(stage6_pipeline_splits_and_proves_each_term) :-
    prove(sum(i,1,n,3*i^2 + 2*i + 1), theorem(method(euler_maclaurin), closed_form(ClosedForm), proof_steps(Steps), _, _)),
    ClosedForm = 3*(n*(n+1)*(2*n+1)/6) + n*(n+1) + n,
    member(split_terms, Steps),
    member(detect_polynomial(3*i^2), Steps),
    member(detect_polynomial(2*i), Steps),
    member(detect_polynomial(1), Steps),
    member(apply_euler_maclaurin_corrections, Steps).

test(stage6_algorithm_mode_keeps_method_specific_steps) :-
    prove(algorithm(sum_squares_compare_methods), theorem(method(compare_methods), _, proof_steps(Steps), _, _)),
    member(run_multiple_methods, Steps),
    member(compare_closed_forms, Steps).

:- end_tests(stage6).
