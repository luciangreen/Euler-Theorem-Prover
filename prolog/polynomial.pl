:- module(polynomial, [expand/2, normalise_sum/2, expand_polynomial_sum/2, split_sum_terms/2]).

normalise_sum(sum(Var, Start, End, Expr), sum(Var, Start, End, Expr)).

expand_polynomial_sum(sum(Var, Start, End, Expr), sum(Var, Start, End, Expanded)) :-
    expand(Expr, Expanded).

expand(Expression, Expanded) :-
    expand_expr(Expression, Expanded0),
    simplify_expr(Expanded0, Expanded).

expand_expr((A+B)^2, Expanded) :-
    !,
    expand_expr(A^2 + 2*A*B + B^2, Expanded).
expand_expr((A-B)^2, Expanded) :-
    !,
    expand_expr(A^2 - 2*A*B + B^2, Expanded).
expand_expr(A+B, EA+EB) :-
    expand_expr(A, EA),
    expand_expr(B, EB).
expand_expr(A-B, EA-EB) :-
    expand_expr(A, EA),
    expand_expr(B, EB).
expand_expr(A*B, EA*EB) :-
    expand_expr(A, EA),
    expand_expr(B, EB).
expand_expr(A/B, EA/EB) :-
    expand_expr(A, EA),
    expand_expr(B, EB).
expand_expr(A^B, EA^EB) :-
    expand_expr(A, EA),
    expand_expr(B, EB).
expand_expr(X, X).

simplify_expr(A+B, S) :-
    simplify_expr(A, SA),
    simplify_expr(B, SB),
    simplify_add(SA, SB, S).
simplify_expr(A-B, S) :-
    simplify_expr(A, SA),
    simplify_expr(B, SB),
    simplify_add(SA, -1*SB, S).
simplify_expr(A*B, S) :-
    simplify_expr(A, SA),
    simplify_expr(B, SB),
    simplify_mul(SA, SB, S).
simplify_expr(A/B, S) :-
    simplify_expr(A, SA),
    simplify_expr(B, SB),
    simplify_div(SA, SB, S).
simplify_expr(A^B, S) :-
    simplify_expr(A, SA),
    simplify_expr(B, SB),
    simplify_pow(SA, SB, S).
simplify_expr(X, X).

simplify_add(0, X, X) :- !.
simplify_add(X, 0, X) :- !.
simplify_add(A, B, S) :- number(A), number(B), !, S is A + B.
simplify_add(A, B, A+B).

simplify_mul(0, _, 0) :- !.
simplify_mul(_, 0, 0) :- !.
simplify_mul(1, X, X) :- !.
simplify_mul(X, 1, X) :- !.
simplify_mul(A, B, S) :- number(A), number(B), !, S is A * B.
simplify_mul(A, B, A*B).

simplify_div(0, _, 0) :- !.
simplify_div(X, 1, X) :- !.
simplify_div(A, B, S) :- number(A), number(B), B =\= 0, !, S is A / B.
simplify_div(A, B, A/B).

simplify_pow(A, B, S) :- number(A), number(B), !, S is A ** B.
simplify_pow(A, B, A^B).

split_sum_terms(Expression, Terms) :-
    split_terms(Expression, Terms0),
    normalize_terms(Terms0, Terms).

split_terms(A+B, Terms) :- !,
    split_terms(A, ATerms),
    split_terms(B, BTerms),
    append(ATerms, BTerms, Terms).
split_terms(A-B, Terms) :- !,
    split_terms(A, ATerms),
    split_terms(B, BTerms),
    negate_terms(BTerms, NBTerms),
    append(ATerms, NBTerms, Terms).
split_terms(Term, [Term]).

negate_terms([], []).
negate_terms([T|Ts], [-1*T|NTs]) :-
    negate_terms(Ts, NTs).

normalize_terms([], []).
normalize_terms([T|Ts], [NT|NTs]) :-
    simplify_expr(T, NT),
    normalize_terms(Ts, NTs).
