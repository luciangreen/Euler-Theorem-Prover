:- begin_tests(stage15).

:- use_module('../prolog/main').

test(stage15_main_predicate_example_shifted_square) :-
    prove(sum(i,1,n,(i+2)^2), Result),
    result_closed_form(Result, n*(n+1)*(2*n+1)/6 + 2*n*(n+1) + 4*n).

test(stage15_supports_required_sum_inputs) :-
    prove(sum(i,1,n,i), R1),
    result_closed_form(R1, n*(n+1)/2),
    prove(sum(i,1,n,i^2), R2),
    result_closed_form(R2, n*(n+1)*(2*n+1)/6),
    prove(sum(i,1,n,i^3), R3),
    result_closed_form(R3, (n*(n+1)/2)^2),
    prove(sum(i,1,n,(i+2)^2), R4),
    result_closed_form(R4, n*(n+1)*(2*n+1)/6 + 2*n*(n+1) + 4*n),
    prove(sum(i,1,n,i^3 + 0.5), R5),
    result_closed_form(R5, (n*(n+1)/2)^2 + n/2),
    prove(sum(i,1,n,3*i^2 + 2*i + 1), R6),
    result_closed_form(R6, 3*(n*(n+1)*(2*n+1)/6) + n*(n+1) + n).

test(stage15_supports_algorithm_inputs_similar_to_gaussian_mode) :-
    prove(algorithm(sum_squares), theorem(method(euler_maclaurin), closed_form(ClosedForm), _, _, _)),
    ClosedForm = n*(n+1)*(2*n+1)/6.

test(stage15_produces_required_result_sections) :-
    prove(sum(i,1,n,i^2), theorem(_, closed_form(_), proof_steps(Steps), child_explanation(Explanation), web_visualisation(Diagrams))),
    Steps \= [],
    Explanation \= [],
    Diagrams \= [].

test(stage15_web_ready_output_projection) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output("sum i from 1 to n of i^2", Theorem, Output),
    is_dict(Output, web_result),
    Output.input = "sum i from 1 to n of i^2",
    get_dict(method, Output, Method),
    string(Method),
    get_dict(closedForm, Output, ClosedForm),
    string(ClosedForm),
    Output.proofSteps \= [],
    Output.childExplanation \= [],
    Output.diagrams \= [].

test(stage15_required_modules_present) :-
    exists_file('prolog/parser.pl'),
    exists_file('prolog/polynomial.pl'),
    exists_file('prolog/integration.pl'),
    exists_file('prolog/euler_maclaurin.pl'),
    exists_file('prolog/simplify.pl'),
    exists_file('prolog/verify.pl'),
    exists_file('prolog/explain_child.pl'),
    exists_file('prolog/main.pl').

:- end_tests(stage15).
