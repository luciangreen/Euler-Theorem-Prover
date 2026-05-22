:- module(simplify, [simplify/2, factor/2, expand/2, verify_identity/2]).

% simplify(+Expr, -Simplified)
%
% Basic symbolic simplification rules.
simplify(X + 0, X) :- !.
simplify(0 + X, X) :- !.
simplify(X * 1, X) :- !.
simplify(1 * X, X) :- !.
simplify(_ * 0, 0) :- !.
simplify(0 * _, 0) :- !.
simplify(N^1, N)   :- !.
simplify(_^0, 1)   :- !.
simplify(X, X).

% factor(+Expr, -Factored)
%
% Known factoring identities.
factor(n^2/2 + n/2, n*(n+1)/2).

% expand(+Expr, -Expanded)
%
% Known expansion identities.
expand(n*(n+1)/2, (n^2+n)/2).

% verify_identity(+Left, +Right)
%
% Check that two symbolic expressions are a known identity.
verify_identity(L, R) :- L == R, !.
verify_identity(n^2/2 + n/2,        n*(n+1)/2).
verify_identity((n*(n+1)/2)^2, n^2*(n+1)^2/4).
