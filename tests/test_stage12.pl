:- begin_tests(stage12).

:- use_module('../prolog/main').
:- use_module(library(readutil)).

file_contains(Path, Needle) :-
    read_file_to_string(Path, Content, []),
    sub_string(Content, _, _, _, Needle).

test(stage12_theorem_contains_required_diagram_descriptors) :-
    prove(sum(i,1,n,i^2), theorem(_, _, _, _, web_visualisation(Diagrams))),
    member(diagram(staircase_sum), Diagrams),
    member(diagram(smooth_integral_curve), Diagrams),
    member(diagram(endpoint_correction), Diagrams),
    member(diagram(split_polynomial_terms), Diagrams).

test(stage12_web_output_diagrams_cover_required_visual_lines) :-
    prove(sum(i,1,n,i^2), Theorem),
    web_output(Theorem, Output),
    DiagramTexts = Output.get(diagrams),
    member("Draw bars for 1^2, 2^2, 3^2, ..., n^2.", DiagramTexts),
    member(SmoothLine, DiagramTexts),
    sub_string(SmoothLine, _, _, _, "Draw a smooth curve y = x^2 over the bars"),
    sub_string(SmoothLine, _, _, _, "integral gives the main area"),
    member("Show that Euler corrections fix the difference between bars and curve.", DiagramTexts).

test(stage12_app_uses_child_friendly_diagram_descriptions) :-
    file_contains('app.js', 'Draw bars for 1^2, 2^2, 3^2, ..., n^2.'),
    file_contains('app.js', 'Draw a smooth curve y = x^2 over the bars and show that the integral gives the main area.'),
    file_contains('app.js', 'Show that Euler corrections fix the difference between bars and curve.').

:- end_tests(stage12).
