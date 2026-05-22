:- begin_tests(stage3).

:- use_module('../prolog/main').

test(parse_web_sum_with_period) :-
    prove("sum i from 1 to n of i^2.", Result),
    result_closed_form(Result, n*(n+1)*(2*n+1)/6).

test(parse_web_sum_general_variable) :-
    prove("sum j from 1 to n of j^3 + 0.5", Result),
    result_closed_form(Result, (n*(n+1)/2)^2 + n/2).

test(compare_methods_algorithm_steps) :-
    prove_algorithm(sum_squares_compare_methods, theorem(method(compare_methods), _, proof_steps(Steps), _, _)),
    member(run_multiple_methods, Steps),
    member(compare_closed_forms, Steps).

test(web_output_projection) :-
    prove(sum(i,1,n,(i+2)^2), Result),
    web_output(Result, Output),
    _ = Output.get(method),
    _ = Output.get(closedForm),
    _ = Output.get(proofSteps),
    _ = Output.get(childExplanation),
    _ = Output.get(diagrams).

:- end_tests(stage3).
