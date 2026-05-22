:- module(main, [
    prove/2,
    explain/2,
    closed_form/2,
    theorem/2,
    derive_sum_power/2,
    sum_power/3,
    bernoulli/2,
    euler_maclaurin/4,
    simplify/2,
    factor/2,
    expand/2,
    verify_identity/2,
    proof_step/2,
    export_proof_json/2,
    convert_proof_to_html/2
]).

:- use_module(euler_maclaurin).
:- use_module(sums).
:- use_module(bernoulli).
:- use_module(simplify).
:- use_module(explain).
