require! {
	fs
	livescript2: livescript
	# terser
}

code = fs.readFileSync \cli.ls \utf8
code = livescript.compile code,
	bare: yes
	header: no
code = "#!/usr/bin/env node\n#code"
# code = await terser.minify code
# code = code.code
fs.writeFileSync \cli.js code
