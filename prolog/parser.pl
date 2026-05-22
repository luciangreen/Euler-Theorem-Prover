:- module(parser, [parse_input/2]).

parse_input(sum(Var, Start, End, Expr), sum(Var, Start, End, Expr)).
parse_input(algorithm(Name), algorithm(Name)).
parse_input(Input, Parsed) :-
    string(Input),
    normalize_space(string(Normalized), Input),
    (   catch(term_string(Term, Normalized), _, fail)
    ->  parse_input(Term, Parsed)
    ;   parse_web_sum(Normalized, Parsed)
    ).

parse_web_sum("sum i from 1 to n of i", sum(i, 1, n, i)).
parse_web_sum("sum i from 1 to n of i^2", sum(i, 1, n, i^2)).
parse_web_sum("sum i from 1 to n of i^3", sum(i, 1, n, i^3)).
parse_web_sum("sum i from 1 to n of (i+2)^2", sum(i, 1, n, (i+2)^2)).
parse_web_sum("sum i from 1 to n of i^3 + 0.5", sum(i, 1, n, i^3 + 0.5)).
parse_web_sum("sum i from 1 to n of 3*i^2 + 2*i + 1", sum(i, 1, n, 3*i^2 + 2*i + 1)).
