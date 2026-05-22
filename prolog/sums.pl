:- module(sums, [closed_form/2, theorem/2]).

% closed_form(+Sum, -Formula)
%
% Known closed-form expressions for power sums.
closed_form(sum(i,1,n,i),   n*(n+1)/2).
closed_form(sum(i,1,n,i^2), n*(n+1)*(2*n+1)/6).
closed_form(sum(i,1,n,i^3), (n*(n+1)/2)^2).

% theorem(+Name, +Statement)
%
% Named theorems as equals/2 terms.
theorem(sum_first_n, equals(sum(i,1,n,i),   n*(n+1)/2)).
theorem(sum_squares, equals(sum(i,1,n,i^2), n*(n+1)*(2*n+1)/6)).
theorem(sum_cubes,   equals(sum(i,1,n,i^3), (n*(n+1)/2)^2)).
