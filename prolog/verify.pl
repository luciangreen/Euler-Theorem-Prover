:- module(verify, [verify_formula/2]).

verify_formula(sum(Var, 1, NAtom, Expr), ClosedForm) :-
    Samples = [1, 2, 3, 5],
    forall(member(NValue, Samples),
           (sum_value(Var, Expr, NAtom, NValue, SumValue),
            expr_value(ClosedForm, NAtom, NValue, _, FormulaValue),
            Diff is abs(SumValue - FormulaValue),
            Diff < 1.0e-8)).

sum_value(_, _, _, 0, 0) :- !.
sum_value(Var, Expr, NAtom, N, Value) :-
    N > 0,
    sum_value_(1, N, Var, Expr, NAtom, 0, Value).

sum_value_(I, N, _, _, _, Acc, Acc) :- I > N, !.
sum_value_(I, N, Var, Expr, NAtom, Acc, Value) :-
    expr_value(Expr, NAtom, N, Var-I, TermValue),
    Next is Acc + TermValue,
    I1 is I + 1,
    sum_value_(I1, N, Var, Expr, NAtom, Next, Value).

expr_value(Number, _, _, _, Number) :- number(Number), !.
expr_value(Atom, NAtom, NValue, Var-IValue, Value) :-
    atom(Atom),
    (   Atom == NAtom
    ->  Value = NValue
    ;   Atom == Var
    ->  Value = IValue
    ;   throw(error(unknown_symbol(Atom), expr_value/5))
    ), !.
expr_value(A+B, NAtom, NValue, Binding, Value) :-
    expr_value(A, NAtom, NValue, Binding, AV),
    expr_value(B, NAtom, NValue, Binding, BV),
    Value is AV + BV.
expr_value(A-B, NAtom, NValue, Binding, Value) :-
    expr_value(A, NAtom, NValue, Binding, AV),
    expr_value(B, NAtom, NValue, Binding, BV),
    Value is AV - BV.
expr_value(A*B, NAtom, NValue, Binding, Value) :-
    expr_value(A, NAtom, NValue, Binding, AV),
    expr_value(B, NAtom, NValue, Binding, BV),
    Value is AV * BV.
expr_value(A/B, NAtom, NValue, Binding, Value) :-
    expr_value(A, NAtom, NValue, Binding, AV),
    expr_value(B, NAtom, NValue, Binding, BV),
    Value is AV / BV.
expr_value(A^B, NAtom, NValue, Binding, Value) :-
    expr_value(A, NAtom, NValue, Binding, AV),
    expr_value(B, NAtom, NValue, Binding, BV),
    Value is AV ** BV.
