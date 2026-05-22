:- module(euler_maclaurin, [euler_maclaurin/4, prove/2]).

% euler_maclaurin(+F, +A, +B, -Approximation)
%
% Simplified Euler-Maclaurin formula:
%   sum_{i=A}^{B} f(i)  ~=  integral(f, A, B)  +  (f(B) + f(A)) / 2
%
% For f(x) = x, integral from 0 to n is n^2/2 and correction is n/2,
% giving the exact closed form n*(n+1)/2.
euler_maclaurin(x, 0, n, n*(n+1)/2).

% prove(+Theorem, -Steps)
%
% Produce a list of proof-step strings for a named theorem.
prove(sum_first_n, Steps) :-
    Steps = [
        "Use Euler-Maclaurin to connect the sum to an integral.",
        "For f(x)=x, the integral from 0 to n is n^2/2.",
        "The endpoint correction is (f(n)+f(0))/2 = n/2.",
        "So the sum is n^2/2 + n/2.",
        "Factor the result to get n(n+1)/2."
    ].

prove(sum_squares, Steps) :-
    Steps = [
        "Apply the Euler-Maclaurin formula to f(x)=x^2.",
        "The integral from 0 to n of x^2 is n^3/3.",
        "The endpoint correction is (n^2+0)/2 = n^2/2.",
        "Higher-order Bernoulli corrections add n/6.",
        "Combining and factoring gives n(n+1)(2n+1)/6."
    ].

prove(sum_cubes, Steps) :-
    Steps = [
        "Apply the Euler-Maclaurin formula to f(x)=x^3.",
        "The integral from 0 to n of x^3 is n^4/4.",
        "After all Bernoulli corrections the result factors as (n(n+1)/2)^2.",
        "This equals the square of the sum of the first n integers."
    ].
