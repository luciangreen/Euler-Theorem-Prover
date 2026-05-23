# Euler-Theorem-Prover

Euler Theorem Prover is a child-friendly SWI-Prolog and web theorem prover for finite sums.
It models sums as staircases, uses integration-inspired reasoning, applies Euler-style corrections,
and returns closed forms with proof steps and child explanations.

## Stage 1 implementation

Stage 1 includes:
- Core project structure with Prolog modules under `prolog/`
- Main proving predicate `prove/2`
- Support for:
  - `sum(i,1,n,i)`
  - `sum(i,1,n,i^2)`
  - `sum(i,1,n,i^3)`
  - `sum(i,1,n,(i+2)^2)`
  - `sum(i,1,n,i^3 + 0.5)`
  - `sum(i,1,n,3*i^2 + 2*i + 1)`
- Algorithm aliases (for example `algorithm(sum_squares)`)
- Child explanation and diagram descriptors
- Basic browser demo (`index.html`, `app.js`)

## Stage 2 implementation

Stage 2 adds:
- `prove_algorithm/3` for extracting closed form and proof steps directly
- Algorithm method variants:
  - integration approximation
  - known formula expansion
  - Euler-Maclaurin
  - split polynomial terms
  - compare methods
- Extended polynomial support in Euler summation up to degree 5 terms
- Stage 2 web demo behavior with method-aware output text

## Stage 3 implementation

Stage 3 adds:
- Flexible web-text parsing for `sum <var> from <start> to <end> of <expr>` inputs
- Method-specific proof-step tails for algorithm modes, including compare-methods steps
- Stage 3 tests for web-text parsing, compare-method algorithm flow, and `web_output/2` projection

## Stage 4 implementation

Stage 4 adds:
- Stage 4 `web_output/2` formatting with method labels and string-based proof/diagram lines for JSON-like web projection
- Explicit `input` field in projected web output for stable web payload shape
- Stage 4 tests for output-shape and method-label behavior

## Stage 5 implementation

Stage 5 adds:
- Child-friendly diagram text projection in `web_output/2` for staircase, curve, endpoint correction, and split-term views
- Method-aware child explanation lines for compare-methods, known-formula, split-term, and integration-approximation flows
- Stage 5 tests for descriptive diagram output and compare-method child explanation text

## Stage 6 implementation

Stage 6 adds:
- Explicit integration-based pipeline steps in `euler_pipeline/2` (`prove_each_term_by_euler`, `combine_term_proofs`, and output packaging)
- Per-term Euler proving flow before combining and verifying the final closed form
- Stage 6 tests validating split-term term proving and method-specific algorithm proof steps

## Stage 7 implementation

Stage 7 adds:
- Explicit symbolic integration rule coverage in `integration.pl` for variable, powers, constants, sum/difference, and scalar multiples
- Stage 7 PL-Unit tests validating the required integration rules from `pr2.txt`
- Stage 7 test wiring in both `npm test` and `tests/run_tests.pl`

## Stage 8 implementation

Stage 8 adds:
- Simplified Euler-Maclaurin coverage checks for required polynomial sums through degree 5
- Canonical closed-form simplification for subtraction terms in Euler polynomial formulas
- Stage 8 tests validating all required examples from the Euler-Maclaurin requirements section

## Run tests

```bash
npm test
```

(Requires SWI-Prolog / `swipl` in your environment.)

## Quick Prolog usage

```prolog
?- [prolog/main].
?- prove(sum(i,1,n,(i+2)^2), Result).
```
