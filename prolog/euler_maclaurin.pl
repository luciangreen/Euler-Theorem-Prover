:- module(euler_maclaurin, [euler_sum/5, euler_maclaurin/5]).

:- use_module(polynomial, [expand/2, split_sum_terms/2]).
:- use_module(em_derivation, [power_sum_polynomial/3]).

euler_maclaurin(Expr, Var, Start, End, ClosedForm) :-
    euler_sum(Expr, Var, Start, End, ClosedForm).

euler_sum(Expr, Var, 1, N, ClosedForm) :-
    atom(N), !,
    expand(Expr, Expanded),
    split_sum_terms(Expanded, Terms),
    prove_terms(Terms, Var, N, TermForms),
    combine_forms(TermForms, Closed0),
    simplify_closed(Closed0, ClosedForm).

% Other limits: the sum from Start to End is F(End) - F(Start - 1), where F
% is the closed form of the sum from 1. This holds for polynomial terms.
euler_sum(Expr, Var, Start, End, ClosedForm) :-
    integer(Start),
    ( atom(End) -> Sym = End ; Sym = n ),
    euler_sum(Expr, Var, 1, Sym, F),
    Before is Start - 1,
    substitute(F, Sym, Before, FBefore0),
    simplify_closed(FBefore0, FBefore),
    (   atom(End)
    ->  ( FBefore == 0 -> ClosedForm = F ; simplify_closed(F - FBefore, ClosedForm) )
    ;   number(End)
    ->  substitute(F, Sym, End, FEnd0),
        simplify_closed(FEnd0, FEnd),
        ClosedForm0 = FEnd - FBefore,
        catch(V is ClosedForm0, _, fail),
        ( V =:= truncate(V) -> ClosedForm is truncate(V) ; ClosedForm = V )
    ).

substitute(X, Sym, Value, Value) :- X == Sym, !.
substitute(X, _, _, X) :- atomic(X), !.
substitute(T, Sym, Value, T1) :-
    T =.. [F|Args],
    maplist([A, A1]>>substitute(A, Sym, Value, A1), Args, Args1),
    T1 =.. [F|Args1].

prove_terms([], _, _, []).
prove_terms([Term|Terms], Var, N, [Closed|Rest]) :-
    prove_term(Term, Var, N, Closed),
    prove_terms(Terms, Var, N, Rest).

prove_term(Var, Var, N, N*(N+1)/2) :- !.
prove_term(Var^1, Var, N, N*(N+1)/2) :- !.
prove_term(Var^2, Var, N, N*(N+1)*(2*N+1)/6) :- !.
prove_term(Var^3, Var, N, (N*(N+1)/2)^2) :- !.
prove_term(Var^4, Var, N, N*(N+1)*(2*N+1)*(3*N^2+3*N-1)/30) :- !.
prove_term(Var^5, Var, N, N^2*(N+1)^2*(2*N^2+2*N-1)/12) :- !.
prove_term(C, _, N, N/2) :- number(C), C =:= 0.5, !.
prove_term(C, _, N, C*N) :- number(C), !.
prove_term(C*Var, Var, N, Closed) :- number(C), !,
    scale_formula(C, N*(N+1)/2, Closed).
prove_term(C1*Var*C2, Var, N, Closed) :- number(C1), number(C2), !,
    C is C1*C2,
    scale_formula(C, N*(N+1)/2, Closed).
prove_term(C*Var^2, Var, N, Closed) :- number(C), !,
    scale_formula(C, N*(N+1)*(2*N+1)/6, Closed).
prove_term(C1*Var^2*C2, Var, N, Closed) :- number(C1), number(C2), !,
    C is C1*C2,
    scale_formula(C, N*(N+1)*(2*N+1)/6, Closed).
prove_term(C*Var^3, Var, N, Closed) :- number(C), !,
    scale_formula(C, (N*(N+1)/2)^2, Closed).
prove_term(C1*Var^3*C2, Var, N, Closed) :- number(C1), number(C2), !,
    C is C1*C2,
    scale_formula(C, (N*(N+1)/2)^2, Closed).
prove_term(C*Var^4, Var, N, Closed) :- number(C), !,
    scale_formula(C, N*(N+1)*(2*N+1)*(3*N^2+3*N-1)/30, Closed).
prove_term(C1*Var^4*C2, Var, N, Closed) :- number(C1), number(C2), !,
    C is C1*C2,
    scale_formula(C, N*(N+1)*(2*N+1)*(3*N^2+3*N-1)/30, Closed).
prove_term(C*Var^5, Var, N, Closed) :- number(C), !,
    scale_formula(C, N^2*(N+1)^2*(2*N^2+2*N-1)/12, Closed).
prove_term(C1*Var^5*C2, Var, N, Closed) :- number(C1), number(C2), !,
    C is C1*C2,
    scale_formula(C, N^2*(N+1)^2*(2*N^2+2*N-1)/12, Closed).
% Higher powers: the polynomial from the Euler-Maclaurin formula, computed
% with exact fractions (em_derivation.pl).
prove_term(Var^P, Var, N, Closed) :- integer(P), P > 5, !,
    power_sum_polynomial(P, N, Closed).
prove_term(C*Var^P, Var, N, Closed) :- number(C), integer(P), P > 5, !,
    power_sum_polynomial(P, N, Poly),
    Closed = C*(Poly).
prove_term(-1*Inner, Var, N, Closed) :- !,
    prove_term(Inner, Var, N, InnerClosed),
    scale_formula(-1, InnerClosed, Closed).
prove_term(Term, _, _, _) :-
    throw(error(unsupported_term(Term), euler_sum/5)).

scale_formula(C, Formula, Scaled) :-
    (   integer(C), Formula = Num/Den, integer(Den), Den =\= 0, 0 is C mod Den
    ->  K is C // Den,
        simplify_closed(K*Num, Scaled)
    ;   simplify_closed(C*Formula, Scaled)
    ).

combine_forms([], 0).
combine_forms([F|Fs], Combined) :-
    foldl(add_form, Fs, F, Combined).

add_form(Next, Acc, Acc+Next).

simplify_closed(Expr, Simplified) :-
    simplify_once(Expr, Expr1),
    (Expr1 == Expr -> Simplified = Expr1 ; simplify_closed(Expr1, Simplified)).

simplify_once(A+B, S) :-
    simplify_closed(A, SA),
    simplify_closed(B, SB),
    simplify_add(SA, SB, S).
simplify_once(A*B, S) :-
    simplify_closed(A, SA),
    simplify_closed(B, SB),
    simplify_mul(SA, SB, S).
simplify_once(A/B, S) :-
    simplify_closed(A, SA),
    simplify_closed(B, SB),
    simplify_div(SA, SB, S).
simplify_once(A-B, S) :-
    simplify_closed(A, SA),
    simplify_closed(B, SB),
    simplify_add(SA, -1*SB, S).
simplify_once(X, X).

simplify_add(0, X, X) :- !.
simplify_add(X, 0, X) :- !.
simplify_add(A, -1*B, S) :- !,
    simplify_sub(A, B, S).
simplify_add(A, B, S) :- number(B), B < 0, !,
    PosB is -B,
    simplify_sub(A, PosB, S).
simplify_add(A, B, S) :- number(A), number(B), !, S is A + B.
simplify_add(A, B, A+B).

simplify_sub(A, 0, A) :- !.
simplify_sub(A, B, S) :- number(A), number(B), !, S is A - B.
simplify_sub(A, B, A+PosB) :- number(B), B < 0, !, PosB is -B.
simplify_sub(A, B, A-B).

simplify_mul(0, _, 0) :- !.
simplify_mul(_, 0, 0) :- !.
simplify_mul(1, X, X) :- !.
simplify_mul(X, 1, X) :- !.
simplify_mul(A*B, C, S) :- number(C), !,
    simplify_mul(C, A*B, S).
simplify_mul(C, A*B, S) :- number(C), number(A), !,
    K is C*A,
    simplify_mul(K, B, S).
simplify_mul(C, A*B, (C*A)*B) :- number(C), !.
simplify_mul(A, B, S) :- number(A), number(B), !, S is A * B.
simplify_mul(A, B, A*B).

simplify_div(0, _, 0) :- !.
simplify_div(X, 1, X) :- !.
simplify_div(A, B, S) :- number(A), number(B), B =\= 0, !, S is A / B.
simplify_div(A, B, A/B).
