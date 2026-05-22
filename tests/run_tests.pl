:- initialization(main).

main :-
    consult('test_linear.pl'),
    consult('test_squares.pl'),
    consult('test_cubes.pl'),
    consult('test_shifted_polynomials.pl'),
    consult('test_decimal_terms.pl'),
    run_tests,
    halt.
