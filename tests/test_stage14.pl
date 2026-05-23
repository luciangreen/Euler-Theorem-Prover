:- begin_tests(stage14).

:- use_module(library(readutil)).

file_contains(Path, Needle) :-
    read_file_to_string(Path, Content, []),
    sub_string(Content, _, _, _, Needle).

test(stage14_readme_has_required_description_sentence_1) :-
    file_contains(
        'README.md',
        'Euler Theorem Prover is a child-friendly Prolog and web theorem prover that derives closed forms for sums by using Euler-style integration, Euler-Maclaurin correction terms, polynomial expansion, and symbolic simplification.'
    ).

test(stage14_readme_has_required_description_sentence_2) :-
    file_contains(
        'README.md',
        'Unlike the Gaussian Theorem Prover, which discovers formulas through pattern tables and Gaussian elimination, this system explains sums as areas, curves, staircases, endpoint corrections, and symbolic integration.'
    ).

:- end_tests(stage14).
