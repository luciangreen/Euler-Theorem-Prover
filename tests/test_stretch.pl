:- begin_tests(stretch).

:- use_module('../prolog/stretch').

test(derive_sum_power_1) :-
    derive_sum_power(1, n*(n+1)/2).

test(derive_sum_power_2) :-
    derive_sum_power(2, n*(n+1)*(2*n+1)/6).

test(derive_sum_power_3) :-
    derive_sum_power(3, (n*(n+1)/2)^2).

test(show_staircase_diagram) :-
    show_staircase_diagram(sum(i,1,n,i), Diagram),
    atomic(Diagram).

test(show_staircase_diagram_contains_sum) :-
    show_staircase_diagram(sum(i,1,n,i), Diagram),
    once(sub_atom(Diagram, _, _, _, 'sum i')).

test(show_staircase_diagram_contains_triangle) :-
    show_staircase_diagram(sum(i,1,n,i), Diagram),
    once(sub_atom(Diagram, _, _, _, 'triangle')).

test(show_staircase_diagram_contains_correction) :-
    show_staircase_diagram(sum(i,1,n,i), Diagram),
    once(sub_atom(Diagram, _, _, _, 'correction')).

test(export_proof_json_sum_first_n) :-
    export_proof_json(sum_first_n, JSON),
    atomic(JSON),
    once(sub_atom(JSON, _, _, _, '[')).

test(export_proof_json_contains_formal) :-
    export_proof_json(sum_first_n, JSON),
    once(sub_atom(JSON, _, _, _, 'formal')).

test(export_proof_json_contains_explanation) :-
    export_proof_json(sum_first_n, JSON),
    once(sub_atom(JSON, _, _, _, 'explanation')).

test(export_proof_json_sum_squares) :-
    export_proof_json(sum_squares, JSON),
    atomic(JSON).

test(export_proof_json_sum_cubes) :-
    export_proof_json(sum_cubes, JSON),
    atomic(JSON).

test(convert_proof_to_html_sum_first_n) :-
    convert_proof_to_html(sum_first_n, HTML),
    atomic(HTML),
    once(sub_atom(HTML, _, _, _, '<ol>')).

test(convert_proof_to_html_contains_li) :-
    convert_proof_to_html(sum_first_n, HTML),
    once(sub_atom(HTML, _, _, _, '<li>')).

test(convert_proof_to_html_sum_squares) :-
    convert_proof_to_html(sum_squares, HTML),
    atomic(HTML).

test(convert_proof_to_html_sum_cubes) :-
    convert_proof_to_html(sum_cubes, HTML),
    atomic(HTML).

:- end_tests(stretch).
