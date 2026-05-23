:- module(explain_child, [child_explanation/2, diagram_descriptions/1]).

child_explanation(ProofSteps, Explanation) :-
    split_line(ProofSteps, SplitLine),
    method_line(ProofSteps, MethodLine),
    Explanation = [
        "The bars in the sum make a staircase shape.",
        "A smooth curve gives an area close to the staircase.",
        "Euler style corrections fix the edge pieces.",
        SplitLine,
        MethodLine,
        "Then we combine the pieces into one formula."
    ].

split_line(ProofSteps, "We split the sum into easier pieces.") :-
    member(split_terms, ProofSteps),
    !.
split_line(_, "We look at the sum as one staircase.").

method_line(ProofSteps, "We compare different methods and check they match.") :-
    member(compare_closed_forms, ProofSteps),
    !.
method_line(ProofSteps, "We use known formulas for each polynomial piece.") :-
    member(apply_known_sum_formulas, ProofSteps),
    !.
method_line(ProofSteps, "We solve each split piece and then add them together.") :-
    member(solve_each_split_term, ProofSteps),
    !.
method_line(ProofSteps, "We balance area and endpoints using Euler-style corrections.") :-
    member(apply_endpoint_balance, ProofSteps),
    !.
method_line(_, "We use Euler-Maclaurin style corrections to reach the exact formula.").

diagram_descriptions([
    diagram(staircase_sum),
    diagram(smooth_integral_curve),
    diagram(endpoint_correction),
    diagram(split_polynomial_terms)
]).
