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
