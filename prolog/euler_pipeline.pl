:- module(euler_pipeline, [euler_pipeline/2]).

:- use_module(parser, [parse_input/2]).
:- use_module(polynomial, [normalise_sum/2, expand_polynomial_sum/2, split_sum_terms/2]).
:- use_module(euler_maclaurin, [euler_sum/5]).
:- use_module(simplify, [simplify/2]).
:- use_module(verify, [verify_formula/2]).
:- use_module(explain_child, [child_explanation/2, diagram_descriptions/1]).
:- use_module(examples, [algorithm_input/2, algorithm_method/2]).

euler_pipeline(Input, Output) :-
    parse_input(Input, Parsed),
    resolve_input(Parsed, Method, SumSpec),
    normalise_sum(SumSpec, Normalised),
    expand_polynomial_sum(Normalised, Expanded),
    split_expanded_sum_terms(Expanded, Terms),
    prove_each_term_by_euler(Terms, Expanded, TermProofs),
    combine_term_proofs(TermProofs, Combined),
    simplify(Combined, ClosedCandidate),
    finalize_closed_form(ClosedCandidate, Combined, ClosedForm),
    verify_formula(SumSpec, ClosedForm),
    TermProofsBundle = term_proofs(Method, Expanded, Terms, TermProofs),
    child_explanation(TermProofsBundle, Explanation),
    package_output(ClosedForm, TermProofsBundle, Explanation, Output).

resolve_input(algorithm(Name), Method, SumSpec) :- !,
    algorithm_input(Name, SumSpec),
    algorithm_method(Name, Method).
resolve_input(SumSpec, euler_maclaurin, SumSpec).

split_expanded_sum_terms(sum(_, _, _, Expr), Terms) :-
    split_sum_terms(Expr, Terms).

prove_each_term_by_euler([], _, []).
prove_each_term_by_euler([Term|Terms], sum(Var, Start, End, _), [TermProof|Rest]) :-
    euler_sum(Term, Var, Start, End, TermClosedForm),
    TermProof = term_proof(Term, TermClosedForm),
    prove_each_term_by_euler(Terms, sum(Var, Start, End, _), Rest).

combine_term_proofs([], 0).
combine_term_proofs([term_proof(_, Closed)|Rest], Combined) :-
    foldl(add_term_closed_form, Rest, Closed, Combined).

add_term_closed_form(term_proof(_, Closed), Acc, Acc+Closed).

finalize_closed_form(ClosedCandidate, Combined, ClosedForm) :-
    (   ClosedCandidate == Combined
    ->  ClosedForm = Combined
    ;   ClosedForm = ClosedCandidate
    ).

package_output(ClosedForm, term_proofs(Method, Expanded, Terms, TermProofs), Explanation, Output) :-
    build_steps(Method, Expanded, Terms, TermProofs, Steps),
    diagram_descriptions(Diagrams),
    Output = theorem(
        method(Method),
        closed_form(ClosedForm),
        proof_steps(Steps),
        child_explanation(Explanation),
        web_visualisation(Diagrams)
    ).

build_steps(Method, sum(_, _, _, Expr), Terms, TermProofs, Steps) :-
    detect_steps(TermProofs, Detect),
    (   Terms = [Expr]
    ->  Prefix = [split_terms]
    ;   Prefix = [expand_polynomial(Expr), split_terms]
    ),
    method_steps(Method, Tail),
    append(Prefix, Detect, Steps0),
    append(Steps0, Tail, Steps).

detect_steps([], []).
detect_steps([term_proof(Term, _)|Rest], [detect_polynomial(Term)|Detect]) :-
    detect_steps(Rest, Detect).

method_steps(euler_maclaurin, [apply_euler_maclaurin_corrections, combine_and_simplify]).
method_steps(integration_approximation, [integrate_curve_area, apply_endpoint_balance, combine_and_simplify]).
method_steps(known_formula_expansion, [apply_known_sum_formulas, combine_and_simplify]).
method_steps(split_polynomial_terms, [solve_each_split_term, combine_and_simplify]).
method_steps(compare_methods, [run_multiple_methods, compare_closed_forms, combine_and_simplify]).
method_steps(_, [apply_euler_maclaurin_corrections, combine_and_simplify]).
