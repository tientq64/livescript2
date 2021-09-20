#!/usr/bin/env node

__dirname = process.cwd()

eval((() => {
	const yargs = require('yargs')

	const argv = yargs
		.usage('ls2 <filepath>')
		.alias('h', 'help')
		.alias('v', 'version')
		.argv

	let [filepath] = argv._

	if (filepath) {
		const fs = require('fs')
		const Path = require('path')
		const livescript = require('./livescript.min.js')
		const require2 = require

		global.require = require = function (path) {
			if (/^\.{0,2}\//.test(path)) {
				return require2(Path.resolve(__dirname, path))
			}
			else {
				return require2(path)
			}
		}

		if (!filepath.endsWith('.ls')) {
			filepath += '.ls'
		}
		filepath = Path.resolve(__dirname, filepath)
		let code = fs.readFileSync(filepath, 'utf8')
		code = livescript.compile(code)
		return code
	}
})())
