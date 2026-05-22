:- module(examples, [algorithm_input/2, algorithm_method/2]).

algorithm_input(sum_first_n, sum(i, 1, n, i)).
algorithm_input(sum_squares, sum(i, 1, n, i^2)).
algorithm_input(sum_cubes, sum(i, 1, n, i^3)).
algorithm_input(shifted_square_sum, sum(i, 1, n, (i+2)^2)).
algorithm_input(cube_plus_half_sum, sum(i, 1, n, i^3 + 0.5)).
algorithm_input(sum_squares_by_integration, sum(i, 1, n, i^2)).
algorithm_input(sum_squares_by_known_formula, sum(i, 1, n, i^2)).
algorithm_input(sum_squares_by_euler_maclaurin, sum(i, 1, n, i^2)).
algorithm_input(sum_squares_by_split_terms, sum(i, 1, n, i^2)).
algorithm_input(sum_squares_compare_methods, sum(i, 1, n, i^2)).

algorithm_method(sum_squares_by_integration, integration_approximation).
algorithm_method(sum_squares_by_known_formula, known_formula_expansion).
algorithm_method(sum_squares_by_euler_maclaurin, euler_maclaurin).
algorithm_method(sum_squares_by_split_terms, split_polynomial_terms).
algorithm_method(sum_squares_compare_methods, compare_methods).
algorithm_method(_, euler_maclaurin).
