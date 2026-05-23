:- begin_tests(stage4).

:- use_module('../prolog/main').

test(web_output_stage4_shape) :-
    prove(sum(i,1,n,(i+2)^2), Result),
    web_output(Result, Output),
    "" = Output.get(input),
    "Euler-Maclaurin integration" = Output.get(method),
    ClosedForm = Output.get(closedForm),
    string(ClosedForm),
    sub_string(ClosedForm, _, _, _, "n"),
    maplist(string, Output.get(proofSteps)),
    maplist(string, Output.get(diagrams)).

test(web_output_compare_method_label) :-
    prove(algorithm(sum_squares_compare_methods), Result),
    web_output(Result, Output),
    "Compare methods" = Output.get(method).

:- end_tests(stage4).
