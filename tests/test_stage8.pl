:- begin_tests(stage8).

:- use_module('../prolog/main').

test(stage8_direct_euler_maclaurin_degree_four) :-
    euler_maclaurin(i^4, i, 1, n, n*(n+1)*(2*n+1)*(3*n^2+3*n-1)/30).

test(stage8_supports_required_polynomial_examples) :-
    prove(sum(i,1,n,i), R1),
    result_closed_form(R1, n*(n+1)/2),
    prove(sum(i,1,n,i^2), R2),
    result_closed_form(R2, n*(n+1)*(2*n+1)/6),
    prove(sum(i,1,n,i^3), R3),
    result_closed_form(R3, (n*(n+1)/2)^2),
    prove(sum(i,1,n,i^4), R4),
    result_closed_form(R4, n*(n+1)*(2*n+1)*(3*n^2+3*n-1)/30),
    prove(sum(i,1,n,(i+2)^2), R5),
    result_closed_form(R5, n*(n+1)*(2*n+1)/6 + 2*n*(n+1) + 4*n),
    prove(sum(i,1,n,i^3 + 0.5), R6),
    result_closed_form(R6, (n*(n+1)/2)^2 + n/2),
    prove(sum(i,1,n,3*i^2 + 2*i + 1), R7),
    result_closed_form(R7, 3*(n*(n+1)*(2*n+1)/6) + n*(n+1) + n).

test(stage8_supports_degree_five_exact_sum) :-
    prove(sum(i,1,n,i^5), Result),
    result_closed_form(Result, n^2*(n+1)^2*(2*n^2+2*n-1)/12).

:- end_tests(stage8).
