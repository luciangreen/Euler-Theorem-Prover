const examples = {
  "sum i from 1 to n of i": {
    closedForm: "n*(n+1)/2",
    proofSteps: ["Use Euler-Maclaurin on i.", "Simplify to triangular number formula."],
    childExplanation: ["We stack bars from 1 to n.", "The smooth area gives n(n+1)/2."],
    diagram: ["staircase_sum", "smooth_integral_curve", "endpoint_correction"]
  },
  "sum i from 1 to n of i^2": {
    closedForm: "n*(n+1)*(2*n+1)/6",
    proofSteps: ["Use Euler-Maclaurin on i^2.", "Apply endpoint corrections."],
    childExplanation: ["Square bars make a staircase.", "Euler corrections match the exact sum."],
    diagram: ["staircase_sum", "smooth_integral_curve", "endpoint_correction"]
  },
  "sum i from 1 to n of (i+2)^2": {
    closedForm: "n*(n+1)*(2*n+1)/6 + 2*n*(n+1) + 4*n",
    proofSteps: [
      "Expand (i+2)^2 into i^2 + 4*i + 4.",
      "Use known Euler formulas for each part.",
      "Combine the formulas."
    ],
    childExplanation: [
      "First open the bracket.",
      "Then solve each easier piece.",
      "Add the pieces for the final answer."
    ],
    diagram: ["split_polynomial_terms", "staircase_sum"]
  }
};

function stringifyLines(lines) {
  return Array.isArray(lines) ? lines.join("\n") : String(lines ?? "");
}

document.getElementById("prove").addEventListener("click", () => {
  const input = document.getElementById("input").value.trim();
  const result = examples[input] ?? {
    closedForm: "Not available in stage 1 web demo.",
    proofSteps: ["Try one of the included example inputs."],
    childExplanation: ["Stage 1 web UI currently serves curated examples."],
    diagram: ["staircase_sum"]
  };

  document.getElementById("closed").textContent = result.closedForm;
  document.getElementById("steps").textContent = stringifyLines(result.proofSteps);
  document.getElementById("child").textContent = stringifyLines(result.childExplanation);
  document.getElementById("diagram").textContent = stringifyLines(result.diagram);
});
