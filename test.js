const
	fs = require("fs")
	livescript = require("./livescript.js")
process.chdir(__dirname)

let code
code = fs.readFileSync("sample.ls", "utf8")
try {
	code = livescript.compile(code)
} catch (err) {
	code = err.stack
}
fs.writeFileSync("sample.js", code)
