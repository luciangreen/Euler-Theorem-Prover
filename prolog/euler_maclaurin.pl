:- module(euler_maclaurin, [euler_sum/5, euler_maclaurin/5]).

:- use_module(polynomial, [expand/2, split_sum_terms/2]).

euler_maclaurin(Expr, Var, Start, End, ClosedForm) :-
    euler_sum(Expr, Var, Start, End, ClosedForm).

euler_sum(Expr, Var, 1, N, ClosedForm) :-
    expand(Expr, Expanded),
    split_sum_terms(Expanded, Terms),
    prove_terms(Terms, Var, N, TermForms),
    combine_forms(TermForms, Closed0),
    simplify_closed(Closed0, ClosedForm).

prove_terms([], _, _, []).
prove_terms([Term|Terms], Var, N, [Closed|Rest]) :-
    prove_term(Term, Var, N, Closed),
    prove_terms(Terms, Var, N, Rest).

prove_term(Var, Var, N, N*(N+1)/2) :- !.
prove_term(Var^2, Var, N, N*(N+1)*(2*N+1)/6) :- !.
prove_term(Var^3, Var, N, (N*(N+1)/2)^2) :- !.
prove_term(Var^4, Var, N, N*(N+1)*(2*N+1)*(3*N^2+3*N-1)/30) :- !.
prove_term(C, _, N, C*N) :- number(C), !.
prove_term(C*Var, Var, N, Closed) :- number(C), !,
    scale_formula(C, N*(N+1)/2, Closed).
prove_term(C*Var^2, Var, N, Closed) :- number(C), !,
    scale_formula(C, N*(N+1)*(2*N+1)/6, Closed).
prove_term(C*Var^3, Var, N, Closed) :- number(C), !,
    scale_formula(C, (N*(N+1)/2)^2, Closed).
prove_term(C*Var^4, Var, N, Closed) :- number(C), !,
    scale_formula(C, N*(N+1)*(2*N+1)*(3*N^2+3*N-1)/30, Closed).
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
combine_forms([F], F) :- !.
combine_forms([F|Fs], F + Rest) :-
    combine_forms(Fs, Rest).

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
