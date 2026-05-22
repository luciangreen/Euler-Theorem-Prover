:- module(euler_pipeline, [euler_pipeline/2]).

:- use_module(parser, [parse_input/2]).
:- use_module(polynomial, [normalise_sum/2, expand_polynomial_sum/2, split_sum_terms/2]).
:- use_module(euler_maclaurin, [euler_sum/5]).
:- use_module(verify, [verify_formula/2]).
:- use_module(explain_child, [child_explanation/2, diagram_descriptions/1]).
:- use_module(examples, [algorithm_input/2, algorithm_method/2]).

euler_pipeline(Input, Output) :-
    parse_input(Input, Parsed),
    resolve_input(Parsed, Method, SumSpec),
    normalise_sum(SumSpec, Normalised),
    expand_polynomial_sum(Normalised, Expanded),
    Expanded = sum(Var, Start, End, Expr),
    split_sum_terms(Expr, Terms),
    euler_sum(Expr, Var, Start, End, ClosedForm),
    verify_formula(SumSpec, ClosedForm),
    build_steps(Expr, Terms, Steps),
    child_explanation(Steps, Explanation),
    diagram_descriptions(Diagrams),
    Output = theorem(
        method(Method),
        closed_form(ClosedForm),
        proof_steps(Steps),
        child_explanation(Explanation),
        web_visualisation(Diagrams)
    ).

resolve_input(algorithm(Name), Method, SumSpec) :- !,
    algorithm_input(Name, SumSpec),
    algorithm_method(Name, Method).
resolve_input(SumSpec, euler_maclaurin, SumSpec).

build_steps(Expr, Terms, Steps) :-
    findall(detect_polynomial(T), member(T, Terms), Detect),
    (   Expr \== Terms
    ->  Prefix = [expand_polynomial(Expr), split_terms]
    ;   Prefix = [split_terms]
    ),
    append(Prefix, Detect, Steps0),
    append(Steps0, [apply_euler_maclaurin_corrections, combine_and_simplify], Steps).
