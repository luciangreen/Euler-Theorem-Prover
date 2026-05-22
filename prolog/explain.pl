:- module(explain, [explain/2, proof_step/2, theorem_proof_steps/2]).

% theorem_proof_steps(+Theorem, -Steps)
%
% Formal proof traces paired with child-friendly explanations.
theorem_proof_steps(sum_first_n, [
    proof_step(
        formal(equals(sum(i,1,n,i), integral(x,0,n,x) + (n+0)/2)),
        explanation("Euler-Maclaurin turns the staircase sum into an area plus a small endpoint correction.")
    ),
    proof_step(
        formal(equals(integral(x,0,n,x), n^2/2)),
        explanation("The area under y=x from 0 to n is a triangle with area n squared over 2.")
    ),
    proof_step(
        formal(equals((n+0)/2, n/2)),
        explanation("At the ends, half of the first and last step together make n over 2.")
    ),
    proof_step(
        formal(equals(sum(i,1,n,i), n^2/2 + n/2)),
        explanation("So the whole sum matches the triangle area plus the endpoint correction.")
    ),
    proof_step(
        formal(equals(n^2/2 + n/2, n*(n+1)/2)),
        explanation("Factoring the result gives n times (n+1) divided by 2.")
    )
]).

theorem_proof_steps(sum_squares, [
    proof_step(
        formal(equals(sum(i,1,n,i^2), integral(x,0,n,x^2) + n^2/2 + n/6)),
        explanation("Euler-Maclaurin starts with the area under y=x squared and then adds correction pieces.")
    ),
    proof_step(
        formal(equals(integral(x,0,n,x^2), n^3/3)),
        explanation("The area under y=x squared from 0 to n is n cubed over 3.")
    ),
    proof_step(
        formal(equals((n^2+0)/2, n^2/2)),
        explanation("The endpoint correction contributes n squared over 2.")
    ),
    proof_step(
        formal(equals(sum(i,1,n,i^2), n^3/3 + n^2/2 + n/6)),
        explanation("Bernoulli-number corrections add the last small piece, n over 6.")
    ),
    proof_step(
        formal(equals(n^3/3 + n^2/2 + n/6, n*(n+1)*(2*n+1)/6)),
        explanation("Putting the pieces together gives the closed form n times (n+1) times (2n+1) over 6.")
    )
]).

theorem_proof_steps(sum_cubes, [
    proof_step(
        formal(equals(sum(i,1,n,i^3), integral(x,0,n,x^3) + bernoulli_corrections(x^3,0,n))),
        explanation("Euler-Maclaurin compares the cube sum with the area under y=x cubed plus correction terms.")
    ),
    proof_step(
        formal(equals(integral(x,0,n,x^3), n^4/4)),
        explanation("The area under y=x cubed from 0 to n is n to the fourth power over 4.")
    ),
    proof_step(
        formal(equals(sum(i,1,n,i^3), n^2*(n+1)^2/4)),
        explanation("After the corrections are added, the sum becomes n squared times (n+1) squared over 4.")
    ),
    proof_step(
        formal(equals(n^2*(n+1)^2/4, (n*(n+1)/2)^2)),
        explanation("That expression is exactly the square of the triangular-number formula.")
    )
]).

% proof_step(+FormalStatement, +Explanation)
%
% Enumerate formal proof steps paired with child-friendly explanations.
proof_step(FormalStatement, Explanation) :-
    theorem_proof_steps(_, Steps),
    member(proof_step(FormalStatement, Explanation), Steps).

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
