if location.hostname is \localhost
	delete window.livescript
	window.eval await (await fetch \livescript.js)text!

if localStorage.livescript2
	opts = JSON.parse localStorage.livescript2
else
	opts =
		code: ""
		compile:
			bare: no
			header: yes
			const: no
			json: no

compile = !->
	try
		code = livescript.compile opts.code, ^^opts.compile
	catch
		code = e + ""
	result.setValue code

saveOpts = !->
	localStorage.livescript2 = JSON.stringify opts

onchangeOptsCompile = (event) !->
	{target} = event
	opts.compile[target.name] = target.checked
	saveOpts!
	compile!

editor = CodeMirror.fromTextArea editorEl,
	mode: \livescript
	keyMap: \sublime
	theme: \monokai
	tabSize: 2
	indentWithTabs: yes
	lineWrapping: yes
	lineNumbers: yes
	showCursorWhenSelecting: yes
	autoCloseBrackets: yes

editor.setValue opts.code

addEventListener \keydown (event) !->
	switch event.code
	| \F1
		event.preventDefault!
		try
			livescript.run opts.code, opts.compile
		catch
			console.error e

editor.on \change (cm, change) !~>
	opts.code = cm.getValue!
	saveOpts!
	compile!

result = CodeMirror.fromTextArea resultEl,
	mode: \javascript
	theme: \monokai
	tabSize: 4
	lineWrapping: yes
	lineNumbers: yes
	readOnly: yes

bare.checked = opts.compile.bare
bare.onchange = onchangeOptsCompile

header.checked = opts.compile.header
header.onchange = onchangeOptsCompile

const2.checked = opts.compile.const
const2.onchange = onchangeOptsCompile

json.checked = opts.compile.json
json.onchange = onchangeOptsCompile

compile!
