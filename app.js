const theoremInput = document.getElementById('theorem-input');
const proveButton = document.getElementById('prove-button');
const proofOutput = document.getElementById('proof-output');
const simplifyOutput = document.getElementById('simplify-output');
const explanationOutput = document.getElementById('explanation-output');

if (proveButton && theoremInput && proofOutput && simplifyOutput && explanationOutput) {
  proveButton.addEventListener('click', () => {
    const theorem = theoremInput.value.trim() || 'sum i from 1 to n';

    proofOutput.textContent = `Stage 1 scaffold captured input: ${theorem}`;
    simplifyOutput.textContent = 'Symbolic simplification will be added in a later stage.';
    explanationOutput.textContent = 'Proof explanations will be added in a later stage.';
  });
}
