:- module(main, [
    prove/2,
    prove_sum/3,
    prove_algorithm/2,
    prove_algorithm/3,
    integrate/3,
    differentiate/3,
    euler_sum/5,
    euler_maclaurin/5,
    simplify/2,
    expand/2,
    factor/2,
    verify_formula/2,
    child_explanation/2,
    web_output/2,
    web_output/3,
    result_closed_form/2
]).

:- use_module(euler_pipeline, [euler_pipeline/2]).
:- use_module(euler_maclaurin, [euler_sum/5, euler_maclaurin/5]).
:- use_module(integration, [integrate/3, differentiate/3]).
:- use_module(simplify, [simplify/2, factor/2]).
:- use_module(polynomial, [expand/2]).
:- use_module(verify, [verify_formula/2]).
:- use_module(explain_child, [child_explanation/2]).
:- use_module(examples, [algorithm_input/2]).

prove(Input, Result) :-
    once(euler_pipeline(Input, Result)).

prove_sum(SumExpression, ClosedForm, ProofSteps) :-
    prove(SumExpression, theorem(_, closed_form(ClosedForm), proof_steps(ProofSteps), _, _)).

prove_algorithm(AlgorithmName, Result) :-
    algorithm_input(AlgorithmName, _),
    prove(algorithm(AlgorithmName), Result).

prove_algorithm(AlgorithmName, ClosedForm, ProofSteps) :-
    prove_algorithm(AlgorithmName, theorem(_, closed_form(ClosedForm), proof_steps(ProofSteps), _, _)).

result_closed_form(theorem(_, closed_form(ClosedForm), _, _, _), ClosedForm).

web_output(Theorem, WebResult) :-
    web_output("", Theorem, WebResult).

web_output(InputText,
           theorem(method(Method), closed_form(ClosedForm), proof_steps(Steps), child_explanation(Explanation), web_visualisation(Diagrams)),
           web_result{
               input: InputText,
               method: MethodLabel,
               closedForm: ClosedFormText,
               proofSteps: StepTexts,
               childExplanation: Explanation,
               diagrams: DiagramTexts
           }) :-
    method_label(Method, MethodLabel),
    term_string(ClosedForm, ClosedFormText),
    maplist(step_text, Steps, StepTexts),
    maplist(diagram_text, Diagrams, DiagramTexts).

method_label(euler_maclaurin, "Euler-Maclaurin integration").
method_label(integration_approximation, "Integration approximation").
method_label(known_formula_expansion, "Known formula expansion").
method_label(split_polynomial_terms, "Split polynomial terms").
method_label(compare_methods, "Compare methods").
method_label(Method, MethodText) :-
    atom(Method),
    atom_string(Method, MethodText).

step_text(split_terms, "Split the sum into separate polynomial terms.") :- !.
step_text(expand_polynomial(Expr), Text) :-
    !,
    term_string(Expr, ExprText),
    string_concat("Expand polynomial expression: ", ExprText, Text).
step_text(detect_polynomial(Term), Text) :-
    !,
    term_string(Term, TermText),
    string_concat("Detect polynomial term: ", TermText, Text).
step_text(apply_euler_maclaurin_corrections, "Apply Euler-Maclaurin correction terms.") :- !.
step_text(integrate_curve_area, "Integrate the smooth curve to estimate area.") :- !.
step_text(apply_endpoint_balance, "Apply endpoint balancing corrections.") :- !.
step_text(apply_known_sum_formulas, "Apply known formulas for each sum.") :- !.
step_text(solve_each_split_term, "Solve each split polynomial term.") :- !.
step_text(run_multiple_methods, "Run multiple proving methods.") :- !.
step_text(compare_closed_forms, "Compare closed forms from each method.") :- !.
step_text(combine_and_simplify, "Combine terms and simplify the closed form.") :- !.
step_text(Step, Text) :-
    term_string(Step, Text).

diagram_text(diagram(Name), Text) :-
    diagram_description(Name, Text),
    !.
diagram_text(diagram(Name), Text) :-
    atom(Name),
    atom_string(Name, Text).

diagram_description(staircase_sum, "Draw bars for 1^2, 2^2, 3^2, ..., n^2.") :- !.
diagram_description(smooth_integral_curve, "Draw a smooth curve y = x^2 over the bars.") :- !.
diagram_description(endpoint_correction, "Show Euler endpoint corrections fixing the edge gap.") :- !.
diagram_description(split_polynomial_terms, "Show split polynomial terms becoming separate easier sums.") :- !.
