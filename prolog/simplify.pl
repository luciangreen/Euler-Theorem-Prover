:- module(simplify, [simplify/2, factor/2]).

:- use_module(euler_maclaurin, [euler_maclaurin/5]).

simplify(Expr, Simplified) :-
    (   Expr = euler_form(F, X, A, B)
    ->  euler_maclaurin(F, X, A, B, Simplified)
    ;   Simplified = Expr
    ).

factor(Expression, Expression).
