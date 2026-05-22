:- begin_tests(bernoulli).

:- use_module('../prolog/bernoulli').

test(bernoulli_0) :-
    bernoulli(0, 1).

test(bernoulli_1) :-
    bernoulli(1, -1/2).

test(bernoulli_2) :-
    bernoulli(2, 1/6).

test(bernoulli_4) :-
    bernoulli(4, -1/30).

test(bernoulli_6) :-
    bernoulli(6, 1/42).

test(sum_power_1) :-
    sum_power(1, n, n*(n+1)/2).

test(sum_power_2) :-
    sum_power(2, n, n*(n+1)*(2*n+1)/6).

test(sum_power_3) :-
    sum_power(3, n, (n*(n+1)/2)^2).

:- end_tests(bernoulli).
