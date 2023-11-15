if location.hostname is \localhost
	delete window.livescript
	window.eval await (await fetch \./livescript.js)text!

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
		org: no
		parse: \ast

saveOpts = !->
	localStorage.livescript2 = JSON.stringify opts

onchangeOpts = (event) !->
	{target} = event
	opts[target.name] = target.checked
	saveOpts!
	compile!

onchangeOptsCompile = (event) !->
	{target} = event
	opts.compile[target.name] = target.checked
	saveOpts!
	compile!

onchangeOptsParse = (event) !->
	{target} = event
	if target.checked
		opts.parse = target.id
		saveOpts!
		compile!

editor = CodeMirror.fromTextArea editorEl,
	mode: \livescript
	keyMap: \sublime
	theme: \monokai
	tabSize: 3
	indentUnit: 3
	indentWithTabs: no
	lineWrapping: yes
	lineNumbers: yes
	showCursorWhenSelecting: yes
	flattenSpans: no
	autoCloseBrackets: yes
	styleActiveLine: yes
	extraKeys:
		"Tab": !~>
			if editor.somethingSelected!
				editor.execCommand \indentMore
			else
				editor.execCommand \insertSoftTab
		"Shift-Tab": !~>
			editor.execCommand \indentLess

editor.setValue opts.code

addEventListener \keydown (event) !->
	switch event.code
	| \F1
		event.preventDefault!
		method = opts.org and livescriptOrg or livescript
		try
			method.run opts.code, opts.compile
		catch
			console.error e

editor.on \change (cm, change) !~>
	opts.code = cm.getValue!
	saveOpts!
	compile!

result = CodeMirror.fromTextArea resultEl,
	mode: \javascript
	theme: \monokai
	tabSize: 3
	lineWrapping: yes
	lineNumbers: yes
	readOnly: yes
	undoDepth: 1

# result2 = CodeMirror.fromTextArea result2El,
# 	mode: \javascript
# 	theme: \monokai
# 	tabSize: 2
# 	lineWrapping: yes
# 	lineNumbers: yes
# 	readOnly: yes
# 	undoDepth: 1

# parser = CodeMirror.fromTextArea parserEl,
# 	mode: \application/json
# 	theme: \monokai
# 	tabSize: 2
# 	lineWrapping: yes
# 	lineNumbers: yes
# 	readOnly: yes
# 	undoDepth: 1

bare.checked = opts.compile.bare
bare.onchange = onchangeOptsCompile

header.checked = opts.compile.header
header.onchange = onchangeOptsCompile

const2.checked = opts.compile.const
const2.onchange = onchangeOptsCompile

json.checked = opts.compile.json
json.onchange = onchangeOptsCompile

org.checked = opts.org
org.onchange = onchangeOpts

# lex.checked = opts.parse is \lex
# lex.onchange = onchangeOptsParse

# tokens.checked = opts.parse is \tokens
# tokens.onchange = onchangeOptsParse

# ast.checked = opts.parse is \ast
# ast.onchange = onchangeOptsParse

compile2 = (tokens, opts) ->
	code = ""
	ifc = 0
	ifb = 0
	scopes = [
		vrs: {}
	]
	scopei = 0
	scope = scopes.0
	for token in tokens
		[id, va, row, col] = token
		{eol, spaced, then: thenn} = token
		switch id
		| \IF
			code += \if(
			ifc++
		| \INDENT
			if ifc
				ifc--
				ifb++
				code += \){
		| \DEDENT
			if ifb
				ifb--
				code += \}
		| \ID
			code += va
		| \+-
			code += va
		| \ASSIGN
			{logic} = va
			op = va + ""
			if op in <[= += -= *= /= %= %%= ^= **=]>
				code += op
		| \CREMENT
			code += va
		| \STRNUM
			code += va
		| \NEWLINE
			code += va
	code

do compile = !->
	method = opts.org and livescriptOrg or livescript
	try
		code = method.compile opts.code, {...opts.compile}
	catch
		code = e + ""
	result.setValue code
	# try
	# 	tokens = method[opts.parse] opts.code
	# 	if opts.parse is \ast
	# 		texts = tokens + ""
	# 	else
	# 		texts = []
	# 		for token in tokens
	# 			text = []
	# 			for k, val of token
	# 				str = (val + "")replace /\n/g \\\n
	# 				if k < 2
	# 					if k is \0
	# 						str .= padEnd 8 " "
	# 					else
	# 						if typeof val is \string
	# 							str = "'#str'"
	# 						else if val instanceof String
	# 							str = str.constructor.name.substring(0 3) + "'#str'"
	# 							for k2, val2 of val
	# 								if isNaN k2
	# 									if val2 is yes
	# 										str += " #k2"
	# 									else if typeof val2 is \string
	# 										str += " #k2:'#val2'"
	# 									else
	# 										str += " #k2:#val2"
	# 						str .= padEnd 18 " "
	# 					text.push str
	# 				else if k > 1
	# 					str .= padEnd 2 " "
	# 					text.push str
	# 				else
	# 					if val is yes
	# 						text.push k
	# 					else if typeof val2 is \string
	# 						text.push "#k:'#val'"
	# 					else
	# 						text.push "#k:#val"
	# 			texts.push text * " "
	# 		texts *= \\n
	# 	parser.setValue texts
	# catch
	# 	parser.setValue e + ""
	# try
	# 	code = compile2 tokens, {...opts.compile}
	# catch
	# 	code = e + ""
	# result2.setValue code
