:- begin_tests(stage10).

:- use_module('../prolog/main').

test(stage10_web_output_has_required_keys) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output(Theorem, Result),
    is_dict(Result, web_result),
    get_dict(method, Result, _),
    get_dict(closedForm, Result, _),
    get_dict(proofSteps, Result, _),
    get_dict(childExplanation, Result, _),
    get_dict(diagrams, Result, _).

test(stage10_web_output_input_defaults_to_empty) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output(Theorem, Result),
    get_dict(input, Result, Input),
    Input = "".

test(stage10_web_output_3_sets_input_text) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output("sum i from 1 to n of i^2", Theorem, Result),
    get_dict(input, Result, "sum i from 1 to n of i^2").

test(stage10_web_output_method_label_is_string) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output(Theorem, Result),
    get_dict(method, Result, Method),
    string(Method).

test(stage10_web_output_closed_form_is_string) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output(Theorem, Result),
    get_dict(closedForm, Result, CF),
    string(CF).

test(stage10_web_output_proof_steps_nonempty) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output(Theorem, Result),
    get_dict(proofSteps, Result, Steps),
    Steps \= [].

test(stage10_web_output_child_explanation_nonempty) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output(Theorem, Result),
    get_dict(childExplanation, Result, Expl),
    Expl \= [].

test(stage10_web_output_euler_maclaurin_method_label) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output(Theorem, Result),
    get_dict(method, Result, "Euler-Maclaurin integration").

test(stage10_web_output_shifted_square_sum) :-
    InputText = "sum i from 1 to n of (i+2)^2",
    prove(sum(i,1,n,(i+2)^2), Theorem),
    web_output(InputText, Theorem, Result),
    get_dict(input, Result, InputText),
    get_dict(closedForm, Result, CF),
    string(CF),
    get_dict(proofSteps, Result, Steps),
    Steps \= [],
    get_dict(childExplanation, Result, Expl),
    Expl \= [].

test(stage10_web_output_proof_step_texts_are_strings) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output(Theorem, Result),
    get_dict(proofSteps, Result, Steps),
    maplist(string, Steps).

:- end_tests(stage10).
