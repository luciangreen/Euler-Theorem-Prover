:- module(integration, [integrate/3, differentiate/3]).

integrate(X, X, X^2/2) :- !.
integrate(X^2, X, X^3/3) :- !.
integrate(X^3, X, X^4/4) :- !.
integrate(C, X, C*X) :- number(C), !.
integrate(A+B, X, IA+IB) :- integrate(A, X, IA), integrate(B, X, IB), !.
integrate(A-B, X, IA-IB) :- integrate(A, X, IA), integrate(B, X, IB), !.
integrate(C*A, X, C*IA) :- number(C), integrate(A, X, IA), !.
integrate(X^K, X, X^(K1)/K1) :- integer(K), K > 0, K1 is K + 1, !.

% Basic derivative support for endpoint corrections.
differentiate(X, X, 1) :- atom(X), !.
differentiate(C, _, 0) :- number(C), !.
differentiate(A+B, X, DA+DB) :- differentiate(A, X, DA), differentiate(B, X, DB), !.
differentiate(A-B, X, DA-DB) :- differentiate(A, X, DA), differentiate(B, X, DB), !.
differentiate(C*A, X, C*DA) :- number(C), differentiate(A, X, DA), !.
differentiate(X^K, X, K*X^(K1)) :- integer(K), K > 1, K1 is K - 1, !.
differentiate(_, _, 0).
