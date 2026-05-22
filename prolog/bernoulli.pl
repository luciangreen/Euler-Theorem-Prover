:- module(bernoulli, [bernoulli/2, sum_power/3]).

% bernoulli(+N, -Value)
%
% Initial Bernoulli numbers used in Faulhaber-style formulas.
bernoulli(0, 1).
bernoulli(1, -1/2).
bernoulli(2, 1/6).
bernoulli(4, -1/30).
bernoulli(6, 1/42).

% sum_power(+K, +N, -Formula)
%
% Closed-form formula for sum_{i=1}^{N} i^K using Bernoulli/Faulhaber.
sum_power(1, n, n*(n+1)/2).
sum_power(2, n, n*(n+1)*(2*n+1)/6).
sum_power(3, n, (n*(n+1)/2)^2).
