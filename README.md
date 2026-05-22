# Euler-Theorem-Prover

Euler Web Theorem Prover is a Prolog-powered symbolic proof system that explains how Euler–Maclaurin reasoning connects sums, integrals, endpoint corrections, Bernoulli numbers, and closed-form formulas for powers. It is designed to be readable by children, students, and GitHub agents.

## Repository structure

```
euler-web-theorem-prover/
  README.md
  index.html
  app.js
  prolog/
    main.pl
    euler_maclaurin.pl
    sums.pl
    bernoulli.pl
    simplify.pl
    explain.pl
  tests/
    test_sums.pl
    test_simplify.pl
    test_euler_maclaurin.pl
    test_bernoulli.pl
```

## Features

- **Prolog theorem prover** — symbolic proof of `∑ i = n(n+1)/2`, `∑ i² = n(n+1)(2n+1)/6`, and `∑ i³ = (n(n+1)/2)²` via Euler–Maclaurin reasoning.
- **Core predicates** — `prove/2`, `closed_form/2`, `sum_power/3`, `simplify/2`, `factor/2`, `expand/2`, `verify_identity/2`, `explain/2`, `derive_sum_power/2`, `export_proof_json/2`, `convert_proof_to_html/2`.
- **Bernoulli numbers** — `bernoulli/2` facts for B₀ … B₆ supporting Faulhaber-style formulas.
- **Child-friendly explanations** — each formal proof step is paired with a plain-language explanation.
- **Web interface** — `index.html` + `app.js` let users type a theorem name or description and see the proof trace, closed form, simplification, and explanation in the browser.

## Theorems

| Name | Statement |
|---|---|
| `sum_first_n` | `∑ i (i=1..n) = n(n+1)/2` |
| `sum_squares` | `∑ i² (i=1..n) = n(n+1)(2n+1)/6` |
| `sum_cubes` | `∑ i³ (i=1..n) = (n(n+1)/2)²` |

## Running in SWI-Prolog

```prolog
?- use_module('prolog/main').
?- prove(sum_first_n, Steps).
?- closed_form(sum(i,1,n,i^2), Formula).
?- explain(sum_first_n, Explanation).
?- derive_sum_power(1, Formula).
?- export_proof_json(sum_first_n, JSON).
?- convert_proof_to_html(sum_first_n, HTML).
```

## Running tests

```sh
cd tests
swipl -g "run_tests, halt" -t "halt(1)" test_sums.pl
swipl -g "run_tests, halt" -t "halt(1)" test_simplify.pl
swipl -g "run_tests, halt" -t "halt(1)" test_euler_maclaurin.pl
swipl -g "run_tests, halt" -t "halt(1)" test_bernoulli.pl
```

## Visual explanation

```
sum  =  staircase area
          ___
        _|   |
      _|     |
    _|       |
   |_________|

integral  =  triangle area
          /|
        /  |
      /    |
    /______|

correction  =  missing half-step area
    ___
   | / |  <-- half of each endpoint step
   |/__|
```

## Euler–Maclaurin connection

For `f(x) = x`:

1. `sum(i, 1, n, i)` ≈ `integral(x, 0, n, x)` + `(f(n) + f(0)) / 2`
2. `integral(x, 0, n, x)` = `n²/2`
3. endpoint correction = `n/2`
4. total = `n²/2 + n/2` = `n(n+1)/2`
