:- module(explain, [explain/2, proof_step/2]).

% proof_step(+FormalStatement, +Explanation)
%
% Formal proof steps paired with child-friendly explanations.
proof_step(
    equals(integral(x,0,n,x), n^2/2),
    explanation("The area under y=x from 0 to n is a triangle with area n squared over 2.")
).

proof_step(
    equals(correction, n/2),
    explanation("The endpoint correction (f(n)+f(0))/2 equals n/2 when f(x)=x.")
).

proof_step(
    equals(n^2/2 + n/2, n*(n+1)/2),
    explanation("Adding the area and correction, then factoring, gives n times (n+1) divided by 2.")
).

% explain(+Theorem, -Steps)
%
% Child-friendly natural-language explanation for a theorem.
explain(sum_first_n, Steps) :-
    Steps = [
        "The sum 1 + 2 + ... + n forms a triangle.",
        "Euler's method connects this staircase-like sum to the area under y = x.",
        "The area gives n\u00b2/2, and the endpoint correction gives n/2.",
        "Together this becomes n(n+1)/2."
    ].

explain(sum_squares, Steps) :-
    Steps = [
        "The sum 1\u00b2 + 2\u00b2 + ... + n\u00b2 counts stacked squares.",
        "Using Bernoulli number corrections the closed form is n(n+1)(2n+1)/6."
    ].

explain(sum_cubes, Steps) :-
    Steps = [
        "The sum 1\u00b3 + 2\u00b3 + ... + n\u00b3 equals the square of the triangular number.",
        "So the closed form is (n(n+1)/2)\u00b2."
    ].
