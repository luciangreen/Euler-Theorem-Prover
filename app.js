// ---------------------------------------------------------------------------
// Euler Web Theorem Prover — stage 2 JavaScript knowledge base
//
// This mirrors the Prolog modules (euler_maclaurin.pl, sums.pl, explain.pl,
// simplify.pl, bernoulli.pl, stretch.pl) so the web interface can display
// proof steps, closed forms, child-friendly explanations, and visual
// staircase diagrams without a Prolog backend.
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

// --- stretch: visual staircase diagrams ------------------------------------

const staircaseDiagrams = {
  sum_first_n: [
    'Staircase for sum i (i = 1..n):',
    '',
    '  n | [#]',
    '... | [#][#]',
    '  2 | [#][#][#]',
    '  1 | [#][#][#][#]',
    '    +--------------',
    '       1  2  3  n',
    '',
    '  [#] = staircase block  ->  discrete sum (sum i)',
    '   /  = triangle edge    ->  integral     \u222b\u2080\u207f x dx = n\u00b2/2',
    '   _  = half-step strip  ->  correction   (f(n)+f(0))/2 = n/2',
    '',
    '  staircase  =  triangle  +  half-step',
    '    \u03a3 i      =  n\u00b2/2    +  n/2   =  n(n+1)/2'
  ],
  sum_squares: [
    'Staircase for sum i\u00b2 (i = 1..n):',
    '',
    '  n | [###]',
    '... | [###][###]',
    '  2 | [###][###][###]',
    '  1 | [###][###][###][###]',
    '    +--------------------',
    '          1    2    3    n',
    '',
    '  [###] = i\u00b2 blocks stacked in column i',
    '',
    '  Euler\u2013Maclaurin breaks this into three pieces:',
    '    integral \u222b\u2080\u207f x\u00b2 dx  =  n\u00b3/3',
    '    endpoint correction =  n\u00b2/2',
    '    Bernoulli correction =  n/6',
    '',
    '  \u03a3 i\u00b2  =  n\u00b3/3 + n\u00b2/2 + n/6  =  n(n+1)(2n+1)/6'
  ],
  sum_cubes: [
    'Staircase for sum i\u00b3 (i = 1..n):',
    '',
    '  The sum of cubes equals the square of the triangular number.',
    '',
    '  Think of it as a square arrangement of the triangular staircase:',
    '',
    '    +-------+',
    '    | T | T |     where T = 1+2+\u2026+n  =  n(n+1)/2',
    '    +---+---+',
    '    | T | T |',
    '    +-------+',
    '',
    '  Side length = T = n(n+1)/2',
    '  Total area  = T\u00b2 = (n(n+1)/2)\u00b2',
    '',
    '  \u03a3 i\u00b3  =  (n(n+1)/2)\u00b2'
  ]
};

// --- DOM wiring -------------------------------------------------------------

const theoremInput  = document.getElementById('theorem-input');
const proveButton   = document.getElementById('prove-button');
const proofOutput   = document.getElementById('proof-output');
const simplifyOutput = document.getElementById('simplify-output');
const explanationOutput = document.getElementById('explanation-output');
const visualOutput  = document.getElementById('visual-output');

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

if (proveButton && theoremInput && proofOutput && simplifyOutput && explanationOutput && visualOutput) {
  proveButton.addEventListener('click', () => {
    const key = normalizeTheoremInput(theoremInput.value);

    if (proofSteps[key]) {
      const steps = proofSteps[key];
      proofOutput.textContent = steps.map((s, i) => `${i + 1}. ${s}`).join('\n');
      simplifyOutput.textContent =
        `Closed form:  ${closedForms[key]}\n\nSimplification: ${simplifyFacts[key]}`;
      explanationOutput.textContent = explanations[key].join('\n');
      visualOutput.textContent = staircaseDiagrams[key].join('\n');
    } else {
      proofOutput.textContent =
        `Unknown theorem \u201c${key}\u201d.\nTry: "sum i from 1 to n", sum_first_n, sum_squares, or sum_cubes.`;
      simplifyOutput.textContent = '';
      explanationOutput.textContent = '';
      visualOutput.textContent = '';
    }
  });
}
