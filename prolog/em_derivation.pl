:- module(em_derivation, [
    bernoulli/2,
    power_sum_coefficients/2,
    power_sum_polynomial/3,
    euler_maclaurin_derivation/3,
    rational_value/2
]).

%% The Euler-Maclaurin formula, computed with exact fractions.
%%
%% For f(i) = i^P, the sum from 1 to N is
%%     integral of x^P from 0 to N             = N^(P+1)/(P+1)
%%   + half the end value f(N)                 = N^P/2
%%   + sum over k of B(2k)/(2k)! * f^(2k-1)(N) = B(2k)/(2k)! * P!/(P-2k+1)! * N^(P-2k+1)
%% (the corrections at 0 vanish for P >= 1). The series stops once 2k-1 > P,
%% so for a power the formula is exact. Fractions are r(Numerator, Denominator).

r_norm(r(N, D), r(N1, D1)) :-
    D =\= 0,
    G is gcd(N, D),
    ( D < 0 -> S = -1 ; S = 1 ),
    N1 is S * N // G,
    D1 is S * D // G.
r_add(r(A, B), r(C, D), R) :- N is A*D + C*B, M is B*D, r_norm(r(N, M), R).
r_mul(r(A, B), r(C, D), R) :- N is A*C, M is B*D, r_norm(r(N, M), R).
r_int(I, r(I, 1)).

rational_value(r(N, D), V) :- ( D =:= 1 -> V = N ; V = N/D ).

factorial(0, 1) :- !.
factorial(N, F) :- N > 0, N1 is N - 1, factorial(N1, F1), F is N * F1.

binomial(N, K, B) :-
    factorial(N, FN), factorial(K, FK), NK is N - K, factorial(NK, FNK),
    B is FN // (FK * FNK).

%% bernoulli(+M, -B): the Bernoulli number B(M) as r(N, D), with B(1) = -1/2.
bernoulli(0, r(1, 1)) :- !.
bernoulli(M, B) :-
    M > 0,
    M1 is M - 1,
    findall(T, ( between(0, M1, K),
                 bernoulli(K, BK),
                 M2 is M + 1,
                 binomial(M2, K, C),
                 r_mul(r(C, 1), BK, T) ), Ts),
    foldl(r_add, Ts, r(0, 1), S),
    M3 is M + 1,
    r_mul(r(-1, M3), S, B).

%% euler_maclaurin_derivation(+P, -N, -Derivation)
%% The three parts of the formula for the sum of i^P, as terms in N.
euler_maclaurin_derivation(P, N, euler_maclaurin(power(P),
        integral(Integral), endpoint(Endpoint), corrections(Corrections))) :-
    integer(P), P >= 1,
    P1 is P + 1,
    Integral = N^P1/P1,
    ( P =:= 1 -> Endpoint = N/2 ; Endpoint = N^P/2 ),
    findall(Term,
            ( between(1, P, K),
              TwoK is 2*K,
              Deg is P - TwoK + 1,
              Deg >= 1,
              bernoulli(TwoK, BK),
              BK = r(BN, _), BN =\= 0,
              factorial(TwoK, F2K),
              factorial(P, FP),
              factorial(Deg, FD),
              r_mul(BK, r(FP, F2K * FD), Coeff),
              fraction_monomial(Coeff, N, Deg, Term) ),
            Corrections).

%% power_sum_coefficients(+P, -Coeffs): Coeffs is a list Degree-r(N, D),
%% highest degree first, for the sum of i^P from 1 to N.
power_sum_coefficients(P, Coeffs) :-
    integer(P), P >= 1,
    P1 is P + 1,
    findall(Deg-C,
            ( between(0, P, J),
              Deg is P1 - J,
              bernoulli(J, BJ0),
              % The sum from 1 uses B(1) = +1/2.
              ( J =:= 1 -> BJ = r(1, 2) ; BJ = BJ0 ),
              binomial(P1, J, Bin),
              r_mul(r(Bin, P1), BJ, C),
              C = r(CN, _), CN =\= 0 ),
            Coeffs).

%% power_sum_polynomial(+P, +N, -Expr): the sum of i^P from 1 to N as a
%% polynomial expression in N.
power_sum_polynomial(P, N, Expr) :-
    power_sum_coefficients(P, Coeffs),
    findall(T, ( member(Deg-C, Coeffs), fraction_monomial(C, N, Deg, T) ), Ts),
    Ts = [First|Rest],
    foldl([T, Acc, Acc+T]>>true, Rest, First, Expr).

% A coefficient times a power of N, kept as an exact fraction: 1/42 n is
% written n/42 and -1/6 n^3 as -1*n^3/6, so simplification does not turn it
% into a decimal.
fraction_monomial(r(Num, Den), N, Deg, T) :-
    ( Deg =:= 1 -> P = N ; P = N^Deg ),
    ( Num =:= 1 -> Top = P ; Top = Num*P ),
    ( Den =:= 1 -> T = Top ; T = Top/Den ).
