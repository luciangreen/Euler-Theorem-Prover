:- begin_tests(simplify).

:- use_module('../prolog/simplify').

test(simplify_add_zero) :-
    simplify(x + 0, x).

test(simplify_mul_one) :-
    simplify(x * 1, x).

test(simplify_mul_zero) :-
    simplify(x * 0, 0).

test(simplify_power_one) :-
    simplify(n^1, n).

test(simplify_power_zero) :-
    simplify(n^0, 1).

test(factor_quadratic) :-
    factor(n^2/2 + n/2, n*(n+1)/2).

test(expand_product) :-
    expand(n*(n+1)/2, (n^2+n)/2).

test(verify_linear_sum) :-
    verify_identity(n^2/2 + n/2, n*(n+1)/2).

test(verify_cubic_sum) :-
    verify_identity((n*(n+1)/2)^2, n^2*(n+1)^2/4).

:- end_tests(simplify).
