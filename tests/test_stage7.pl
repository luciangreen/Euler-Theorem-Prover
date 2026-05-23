:- begin_tests(stage7).

:- use_module('../prolog/main').

test(integrate_variable_rule) :-
    integrate(i, i, i^2/2).

test(integrate_square_rule) :-
    integrate(i^2, i, i^3/3).

test(integrate_cube_rule) :-
    integrate(i^3, i, i^4/4).

test(integrate_constant_rule) :-
    integrate(7, i, 7*i).

test(integrate_addition_rule) :-
    integrate(i+2, i, i^2/2+2*i).

test(integrate_subtraction_rule) :-
    integrate(i^2-i, i, i^3/3-i^2/2).

test(integrate_scalar_multiplication_rule) :-
    integrate(3*i^2, i, 3*(i^3/3)).

test(integrate_generic_power_rule) :-
    integrate(i^4, i, i^5/5).

:- end_tests(stage7).
