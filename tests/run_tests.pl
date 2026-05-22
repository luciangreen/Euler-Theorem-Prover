:- initialization(main).

main :-
    Files = [
        'tests/test_linear.pl',
        'tests/test_squares.pl',
        'tests/test_cubes.pl',
        'tests/test_shifted_polynomials.pl',
        'tests/test_decimal_terms.pl',
        'tests/test_stage2.pl',
        'tests/test_stage3.pl'
    ],
    maplist(consult, Files),
    (   run_tests
    ->  halt(0)
    ;   halt(1)
    ).
