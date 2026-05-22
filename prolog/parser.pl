:- module(parser, [parse_input/2]).

:- use_module(library(pcre)).

parse_input(sum(Var, Start, End, Expr), sum(Var, Start, End, Expr)) :- !.
parse_input(algorithm(Name), algorithm(Name)) :- !.
parse_input(Input, Parsed) :-
    string(Input),
    normalize_space(string(Normalized), Input),
    (   catch(term_string(Term, Normalized), _, fail)
    ->  parse_input(Term, Parsed)
    ;   parse_web_sum(Normalized, Parsed)
    ).

parse_web_sum(Text, sum(Var, Start, End, Expr)) :-
    re_matchsub("^sum\\s+(?<var>[A-Za-z_][A-Za-z0-9_]*)\\s+from\\s+(?<start>[^\\s]+)\\s+to\\s+(?<end>[^\\s]+)\\s+of\\s+(?<expr>.+?)\\.?$",
                Text, Dict, []),
    atom_string(Var, Dict.var),
    term_string(Start, Dict.start),
    term_string(End, Dict.end),
    normalize_space(string(ExprText), Dict.expr),
    term_string(Expr, ExprText).
