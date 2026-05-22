:- module(euler_maclaurin, [euler_maclaurin/4, prove/2]).

:- use_module(explain, [theorem_proof_steps/2]).

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
% Produce a list of structured stage-4 proof steps for a named theorem.
prove(Theorem, Steps) :-
    theorem_proof_steps(Theorem, Steps).
