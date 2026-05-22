:- module(main, [
    prove/2,
    prove_sum/3,
    prove_algorithm/2,
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
    algorithm_input(AlgorithmName, Sum),
    prove(Sum, Result).

result_closed_form(theorem(_, closed_form(ClosedForm), _, _, _), ClosedForm).

web_output(theorem(method(Method), closed_form(ClosedForm), proof_steps(Steps), child_explanation(Explanation), web_visualisation(Diagrams)),
           web_result{
               method: Method,
               closedForm: ClosedForm,
               proofSteps: Steps,
               childExplanation: Explanation,
               diagrams: Diagrams
           }).
