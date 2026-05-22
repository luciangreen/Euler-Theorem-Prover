:- module(explain_child, [child_explanation/2, diagram_descriptions/1]).

child_explanation(ProofSteps, Explanation) :-
    (   member(split_terms, ProofSteps)
    ->  SplitLine = "We split the sum into easier pieces."
    ;   SplitLine = "We look at the sum as one staircase."
    ),
    Explanation = [
        "The bars in the sum make a staircase shape.",
        "A smooth curve gives an area close to the staircase.",
        "Euler style corrections fix the edge pieces.",
        SplitLine,
        "Then we combine the pieces into one formula."
    ].

diagram_descriptions([
    diagram(staircase_sum),
    diagram(smooth_integral_curve),
    diagram(endpoint_correction),
    diagram(split_polynomial_terms)
]).
