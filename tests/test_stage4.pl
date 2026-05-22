:- begin_tests(stage4).

:- use_module('../prolog/main').

test(sum_fourth_powers) :-
    prove(sum(i,1,n,i^4), Result),
    result_closed_form(Result, n*(n+1)*(2*n+1)*(3*n^2+3*n-1)/30).

test(web_output_rich_projection) :-
    Input = "sum i from 1 to n of i^2",
    prove(Input, Result),
    web_output(Input, Result, Output),
    Output.get(input) = Input,
    Output.get(method) = euler_maclaurin,
    Output.get(methodText) = 'Euler-Maclaurin integration',
    Output.get(closedFormText) = "n*(n+1)*(2*n+1)/6",
    _ = Output.get(proofStepText),
    _ = Output.get(diagramText).

:- end_tests(stage4).
