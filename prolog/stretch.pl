:- module(stretch, [
    derive_sum_power/2,
    show_staircase_diagram/2,
    export_proof_json/2,
    convert_proof_to_html/2
]).

:- use_module(bernoulli, [sum_power/3]).
:- use_module(explain,   [theorem_proof_steps/2]).

% derive_sum_power(+K, -Formula)
%
% Derive the closed-form formula for sum_{i=1}^{n} i^K using Faulhaber/Bernoulli.
derive_sum_power(K, Formula) :-
    sum_power(K, n, Formula).

% show_staircase_diagram(+Sum, -Diagram)
%
% Produce an ASCII diagram illustrating the three geometric pieces
% of the Euler-Maclaurin argument for sum(i,1,n,i):
%
%   sum = staircase area
%   integral = triangle area
%   correction = missing half-step area
show_staircase_diagram(sum(i,1,n,i), Diagram) :-
    Lines = [
        'Staircase for sum i (i = 1..n):',
        '',
        '  n | [#]',
        '... | [#][#]',
        '  2 | [#][#][#]',
        '  1 | [#][#][#][#]',
        '    +--------------',
        '       1  2  3  n',
        '',
        '  [#] = staircase block  ->  discrete sum (sum i)',
        '   /  = triangle edge    ->  integral     integral_0^n x dx = n^2/2',
        '   _  = half-step strip  ->  correction   (f(n)+f(0))/2 = n/2',
        '',
        '  staircase  =  triangle  +  half-step',
        '    sum i    =  n^2/2    +  n/2   =  n*(n+1)/2'
    ],
    atomic_list_concat(Lines, '\n', Diagram).

% export_proof_json(+Theorem, -JSON)
%
% Serialise the proof steps for Theorem as a JSON array string.
export_proof_json(Theorem, JSON) :-
    theorem_proof_steps(Theorem, Steps),
    steps_to_json_items(Steps, Items),
    atomic_list_concat(Items, ',\n  ', Inner),
    format(atom(JSON), '[\n  ~w\n]', [Inner]).

steps_to_json_items([], []).
steps_to_json_items([proof_step(formal(F), explanation(E))|T], [Item|Rest]) :-
    term_to_atom(F, FAtom),
    format(atom(Item), '{"formal":"~w","explanation":"~w"}', [FAtom, E]),
    steps_to_json_items(T, Rest).

% convert_proof_to_html(+Theorem, -HTML)
%
% Render the proof steps for Theorem as an HTML ordered-list string.
convert_proof_to_html(Theorem, HTML) :-
    theorem_proof_steps(Theorem, Steps),
    steps_to_html_items(Steps, Items),
    atomic_list_concat(Items, '\n', Inner),
    format(atom(HTML), '<ol>\n~w\n</ol>', [Inner]).

steps_to_html_items([], []).
steps_to_html_items([proof_step(formal(F), explanation(E))|T], [Item|Rest]) :-
    term_to_atom(F, FAtom),
    format(atom(Item),
        '<li><strong>~w</strong><br><em>~w</em></li>',
        [FAtom, E]),
    steps_to_html_items(T, Rest).
