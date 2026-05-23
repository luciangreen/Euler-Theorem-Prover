:- begin_tests(stage11).

:- use_module(library(readutil)).

file_contains(Path, Needle) :-
    read_file_to_string(Path, Content, []),
    sub_string(Content, _, _, _, Needle).

test(stage11_index_has_input_theorem_box) :-
    file_contains('index.html', '<label for="input">Input theorem</label>'),
    file_contains('index.html', '<textarea id="input">').

test(stage11_index_has_method_dropdown_and_required_options) :-
    file_contains('index.html', '<label for="method">Choose method</label>'),
    file_contains('index.html', '<select id="method">'),
    file_contains('index.html', '<option>Euler-Maclaurin</option>'),
    file_contains('index.html', '<option>Integration approximation</option>'),
    file_contains('index.html', '<option>Known formula expansion</option>'),
    file_contains('index.html', '<option>Split polynomial terms</option>'),
    file_contains('index.html', '<option>Compare methods</option>').

test(stage11_index_has_prove_button_and_outputs) :-
    file_contains('index.html', '<button id="prove">Prove</button>'),
    file_contains('index.html', '<h2>Closed form output</h2>'),
    file_contains('index.html', '<pre id="closed"></pre>'),
    file_contains('index.html', '<h2>Formal proof steps</h2>'),
    file_contains('index.html', '<pre id="steps"></pre>'),
    file_contains('index.html', '<h2>Child explanation</h2>'),
    file_contains('index.html', '<pre id="child"></pre>'),
    file_contains('index.html', '<h2>Optional staircase diagram</h2>'),
    file_contains('index.html', '<pre id="diagram"></pre>').

test(stage11_app_wires_button_method_and_outputs) :-
    file_contains('app.js', 'document.getElementById("prove").addEventListener("click",'),
    file_contains('app.js', 'const method = document.getElementById("method").value;'),
    file_contains('app.js', 'document.getElementById("closed").textContent = result.closedForm;'),
    file_contains('app.js', 'document.getElementById("steps").textContent = stringifyLines(result.proofSteps);'),
    file_contains('app.js', 'document.getElementById("child").textContent = stringifyLines(result.childExplanation);'),
    file_contains('app.js', 'document.getElementById("diagram").textContent = stringifyLines(result.diagrams);').

:- end_tests(stage11).
