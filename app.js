// ---------------------------------------------------------------------------
// Euler Web Theorem Prover — stage 7 JavaScript knowledge base
//
// This mirrors the Prolog modules (euler_maclaurin.pl, sums.pl, explain.pl,
// simplify.pl, bernoulli.pl) so the web interface can display proof steps,
// closed forms, and child-friendly explanations without a Prolog backend.
// ---------------------------------------------------------------------------

// --- euler_maclaurin: prove/2 -----------------------------------------------

const proofSteps = {
  sum_first_n: [
    'Use Euler-Maclaurin to connect the sum to an integral.',
    'For f(x)=x, the integral from 0 to n is n\u00b2/2.',
    'The endpoint correction is (f(n)+f(0))/2 = n/2.',
    'So the sum is n\u00b2/2 + n/2.',
    'Factor the result to get n(n+1)/2.'
  ],
  sum_squares: [
    'Apply the Euler-Maclaurin formula to f(x)=x\u00b2.',
    'The integral from 0 to n of x\u00b2 is n\u00b3/3.',
    'The endpoint correction is (n\u00b2+0)/2 = n\u00b2/2.',
    'Higher-order Bernoulli corrections add n/6.',
    'Combining and factoring gives n(n+1)(2n+1)/6.'
  ],
  sum_cubes: [
    'Apply the Euler-Maclaurin formula to f(x)=x\u00b3.',
    'The integral from 0 to n of x\u00b3 is n\u2074/4.',
    'After all Bernoulli corrections the result factors as (n(n+1)/2)\u00b2.',
    'This equals the square of the sum of the first n integers.'
  ]
};

// --- sums: closed_form/2 ----------------------------------------------------

const closedForms = {
  sum_first_n:  '\u03a3 i (i=1..n)   =  n(n+1)/2',
  sum_squares:  '\u03a3 i\u00b2 (i=1..n)  =  n(n+1)(2n+1)/6',
  sum_cubes:    '\u03a3 i\u00b3 (i=1..n)  =  (n(n+1)/2)\u00b2'
};

// --- simplify: key identities -----------------------------------------------

const simplifyFacts = {
  sum_first_n:  'n\u00b2/2 + n/2  \u27f6  n(n+1)/2',
  sum_squares:  'n\u00b3/3 + n\u00b2/2 + n/6  \u27f6  n(n+1)(2n+1)/6',
  sum_cubes:    '(n\u00b2(n+1)\u00b2)/4  \u27f6  (n(n+1)/2)\u00b2'
};

// --- explain: child-friendly explanations -----------------------------------

const explanations = {
  sum_first_n: [
    'The sum 1 + 2 + \u2026 + n forms a triangle.',
    "Euler\u2019s method connects this staircase-like sum to the area under y\u202f=\u202fx.",
    'The area gives n\u00b2/2, and the endpoint correction gives n/2.',
    'Together this becomes n(n+1)/2.'
  ],
  sum_squares: [
    'The sum 1\u00b2 + 2\u00b2 + \u2026 + n\u00b2 counts stacked squares.',
    'Using Bernoulli number corrections the closed form is n(n+1)(2n+1)/6.'
  ],
  sum_cubes: [
    'The sum 1\u00b3 + 2\u00b3 + \u2026 + n\u00b3 equals the square of the triangular number.',
    'So the closed form is (n(n+1)/2)\u00b2.'
  ]
};

// --- staircase visual diagrams (show_staircase_diagram) ---------------------

const staircaseDiagrams = {
  sum_first_n: [
    'sum  =  staircase area',
    '          ___',
    '        _|   |',
    '      _|     |',
    '    _|       |',
    '   |_________|',
    '',
    'integral  =  triangle area',
    '          /|',
    '        /  |',
    '      /    |',
    '    /______|',
    '',
    'correction  =  missing half-step area',
    '    ___',
    '   | / |  <-- half of each endpoint step',
    '   |/__|'
  ].join('\n'),
  sum_squares: [
    'sum  =  stacked squares',
    '    ___',
    '   |___|',
    '   |___|___',
    '   |___|___|___',
    '',
    'Each column has height i\u00b2 at position i.'
  ].join('\n'),
  sum_cubes: [
    'sum  =  (triangular number)\u00b2',
    '',
    '  1\u00b3 + 2\u00b3 + 3\u00b3 + \u2026 + n\u00b3  =  (1 + 2 + \u2026 + n)\u00b2',
    '',
    '  The cube sum equals the square of the triangular number.'
  ].join('\n')
};

// --- DOM wiring -------------------------------------------------------------

const theoremInput  = document.getElementById('theorem-input');
const proveButton   = document.getElementById('prove-button');
const proofOutput   = document.getElementById('proof-output');
const simplifyOutput = document.getElementById('simplify-output');
const explanationOutput = document.getElementById('explanation-output');

function normalizeTheoremInput(input) {
  const text = (input || '').trim().toLowerCase();
  if (!text) return 'sum_first_n';

  const aliases = {
    sum_first_n: 'sum_first_n',
    'sum i from 1 to n': 'sum_first_n',
    'sum of first n integers': 'sum_first_n',
    sum_squares: 'sum_squares',
    'sum i^2 from 1 to n': 'sum_squares',
    'sum of squares': 'sum_squares',
    sum_cubes: 'sum_cubes',
    'sum i^3 from 1 to n': 'sum_cubes',
    'sum of cubes': 'sum_cubes'
  };

  if (aliases[text]) return aliases[text];
  return text.replace(/\s+/g, '_');
}

if (proveButton && theoremInput && proofOutput && simplifyOutput && explanationOutput) {
  proveButton.addEventListener('click', () => {
    const key = normalizeTheoremInput(theoremInput.value);

    if (proofSteps[key]) {
      const steps = proofSteps[key];
      proofOutput.textContent = steps.map((s, i) => `${i + 1}. ${s}`).join('\n');
      simplifyOutput.textContent =
        `Closed form:  ${closedForms[key]}\n\nSimplification: ${simplifyFacts[key]}`;
      const diagram = staircaseDiagrams[key] ? '\n\n' + staircaseDiagrams[key] : '';
      explanationOutput.textContent = explanations[key].join('\n') + diagram;
    } else {
      proofOutput.textContent =
        `Unknown theorem \u201c${key}\u201d.\nTry: "sum i from 1 to n", sum_first_n, sum_squares, or sum_cubes.`;
      simplifyOutput.textContent = '';
      explanationOutput.textContent = '';
    }
  });
}
