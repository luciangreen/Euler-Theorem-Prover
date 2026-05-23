:- begin_tests(stage5).

:- use_module('../prolog/main').

test(web_output_diagram_descriptions_are_child_friendly) :-
    prove(sum(i,1,n,i^2), Result),
    web_output(Result, Output),
    DiagramTexts = Output.get(diagrams),
    member("Draw bars for 1^2, 2^2, 3^2, ..., n^2.", DiagramTexts),
    member("Draw a smooth curve y = x^2 over the bars.", DiagramTexts).

test(compare_methods_child_explanation_mentions_comparison) :-
    prove(algorithm(sum_squares_compare_methods), Result),
    web_output(Result, Output),
    Explanation = Output.get(childExplanation),
    member(Line, Explanation),
    sub_string(Line, _, _, _, "compare different methods"),
    !.

:- end_tests(stage5).
