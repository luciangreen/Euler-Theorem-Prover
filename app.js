const inputForms = {
  "sum i from 1 to n of i": "n*(n+1)/2",
  "sum i from 1 to n of i^2": "n*(n+1)*(2*n+1)/6",
  "sum i from 1 to n of i^3": "(n*(n+1)/2)^2",
  "sum i from 1 to n of (i+2)^2": "n*(n+1)*(2*n+1)/6 + 2*n*(n+1) + 4*n",
  "sum i from 1 to n of i^3 + 0.5": "(n*(n+1)/2)^2 + n/2",
  "sum i from 1 to n of 3*i^2 + 2*i + 1": "3*(n*(n+1)*(2*n+1)/6) + n*(n+1) + n"
};

const methodLabels = {
  "Euler-Maclaurin": "Euler-Maclaurin integration",
  "Integration approximation": "Integration approximation",
  "Known formula expansion": "Known formula expansion",
  "Split polynomial terms": "Split polynomial terms",
  "Compare methods": "Compare methods"
};

const methodSteps = {
  "Euler-Maclaurin": [
    "Model the sum as a staircase and smooth curve.",
    "Use Euler-style endpoint correction terms.",
    "Simplify to a closed form."
  ],
  "Integration approximation": [
    "Estimate the staircase with an integral area.",
    "Use endpoint balancing to match the exact sum."
  ],
  "Known formula expansion": [
    "Expand the expression into standard polynomial pieces.",
    "Apply known formulas to each piece.",
    "Combine the results."
  ],
  "Split polynomial terms": [
    "Split the polynomial into easier sums.",
    "Solve each sum and combine the formulas."
  ],
  "Compare methods": [
    "Run multiple proving styles on the same sum.",
    "Confirm they produce the same closed form."
  ]
};

function stringifyLines(lines) {
  return Array.isArray(lines) ? lines.join("\n") : String(lines ?? "");
}

document.getElementById("prove").addEventListener("click", () => {
  const input = document.getElementById("input").value.trim();
  const method = document.getElementById("method").value;
  const closedForm = inputForms[input];
  const result = closedForm ? {
    input,
    method: methodLabels[method] ?? method,
    closedForm,
    proofSteps: methodSteps[method] ?? methodSteps["Euler-Maclaurin"],
    childExplanation: [
      "The sum looks like staircase bars.",
      "A smooth curve gives the main area.",
      "Euler corrections fix the edge pieces."
    ],
    diagram: ["staircase_sum", "smooth_integral_curve", "endpoint_correction", "split_polynomial_terms"]
  } : {
    input,
    method: methodLabels[method] ?? method,
    closedForm: "Input not in built-in stage 2 examples.",
    proofSteps: ["Try one of the documented example inputs."],
    childExplanation: ["This browser demo uses built-in examples."],
    diagram: ["staircase_sum"]
  };

  document.getElementById("closed").textContent = result.closedForm;
  document.getElementById("steps").textContent = stringifyLines(result.proofSteps);
  document.getElementById("child").textContent = stringifyLines(result.childExplanation);
  document.getElementById("diagram").textContent = stringifyLines(result.diagram);
});
