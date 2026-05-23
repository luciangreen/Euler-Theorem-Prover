:- module(explain_child, [child_explanation/2, diagram_descriptions/1]).

child_explanation(ProofSteps, Explanation) :-
    proof_markers(ProofSteps, Markers),
    split_line(Markers, SplitLine),
    method_line(Markers, MethodLine),
    Explanation = [
        "The bars in the sum make a staircase shape.",
        "A smooth curve gives an area close to the staircase.",
        "Euler style corrections fix the edge pieces.",
        SplitLine,
        MethodLine,
        "Then we combine the pieces into one formula."
    ].

proof_markers(term_proofs(Method, sum(_, _, _, Expr), Terms, TermProofs), Markers) :-
    detect_markers(TermProofs, DetectMarkers),
    (   Terms = [Expr]
    ->  Prefix = [split_terms]
    ;   Prefix = [expand_polynomial(Expr), split_terms]
    ),
    method_markers(Method, MethodMarkers),
    append(Prefix, DetectMarkers, Steps0),
    append(Steps0, MethodMarkers, Markers).
proof_markers(ProofSteps, ProofSteps).

detect_markers([], []).
detect_markers([term_proof(Term, _)|Rest], [detect_polynomial(Term)|Markers]) :-
    detect_markers(Rest, Markers).

method_markers(euler_maclaurin, [apply_euler_maclaurin_corrections, combine_and_simplify]).
method_markers(integration_approximation, [integrate_curve_area, apply_endpoint_balance, combine_and_simplify]).
method_markers(known_formula_expansion, [apply_known_sum_formulas, combine_and_simplify]).
method_markers(split_polynomial_terms, [solve_each_split_term, combine_and_simplify]).
method_markers(compare_methods, [run_multiple_methods, compare_closed_forms, combine_and_simplify]).
method_markers(_, [apply_euler_maclaurin_corrections, combine_and_simplify]).

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
