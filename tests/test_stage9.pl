:- begin_tests(stage9).

:- use_module('../prolog/main').

test(stage9_algorithm_modes_produce_same_square_sum_closed_form) :-
    Expected = n*(n+1)*(2*n+1)/6,
    Algorithms = [
        sum_squares_by_integration,
        sum_squares_by_known_formula,
        sum_squares_by_euler_maclaurin,
        sum_squares_by_split_terms
    ],
    maplist(assert_algorithm_closed_form(Expected), Algorithms).

test(stage9_algorithm_mode_returns_required_components) :-
    prove_algorithm(sum_squares_by_integration, theorem(method(Method), closed_form(ClosedForm), proof_steps(Steps), child_explanation(Explanation), _)),
    atom(Method),
    ClosedForm = n*(n+1)*(2*n+1)/6,
    Steps \= [],
    Explanation \= [].

assert_algorithm_closed_form(Expected, Algorithm) :-
    prove_algorithm(Algorithm, theorem(method(_), closed_form(ClosedForm), proof_steps(_), child_explanation(_), _)),
    ClosedForm = Expected.

:- end_tests(stage9).
