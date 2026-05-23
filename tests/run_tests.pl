:- initialization(main).

main :-
    Files = [
        'tests/test_linear.pl',
        'tests/test_squares.pl',
        'tests/test_cubes.pl',
        'tests/test_shifted_polynomials.pl',
        'tests/test_decimal_terms.pl',
        'tests/test_stage2.pl',
        'tests/test_stage3.pl',
        'tests/test_stage4.pl',
        'tests/test_stage5.pl',
        'tests/test_stage6.pl',
        'tests/test_stage7.pl',
        'tests/test_stage8.pl',
        'tests/test_stage9.pl',
        'tests/test_stage10.pl',
        'tests/test_stage11.pl',
        'tests/test_stage12.pl',
        'tests/test_stage13.pl',
        'tests/test_stage14.pl'
    ],
    maplist(consult, Files),
    (   run_tests
    ->  halt(0)
    ;   halt(1)
    ).
