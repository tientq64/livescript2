__dirname = process.cwd!
require! {
	fs
	path
	yargs
	\./livescript.min.js
}
{argv} = yargs
	.command "ls2 <filepath>" "Run code"
	.command "ls2 -c <src> <dist>" "Compile code"
	.option \c,
		alias: \compile
		type: \array
		describe: "Compile filepath"
	.option \b,
		alias: \bare
		type: \boolean
		default: no
		describe: "Compile without the top-level function wrapper"
	.option \e,
		alias: \header
		type: \boolean
		default: yes
		describe: "Add the \"Generated by\" header"
	.option \n,
		type: \boolean
		describe: "Negate of --header"
	.alias \h \help
	.alias \v \version
switch
| argv.compile
	if argv.compile.length < 2
		throw Error "Missing <src> or <dist>"
	else
		[src, dist] = argv.compile
		{bare, header} = argv
		src = path.resolve __dirname, src
		dist = path.resolve __dirname, dist
		header = no if argv.n
		code = fs.readFileSync src, \utf8
		code = livescript.compile code,
			bare: bare
			header: header
		fs.writeFileSync dist, code
else
	eval let
		[filepath] = argv._
		if filepath
			require = global.require = (file) ->
				if /^\.{0,2}\//test file
					module.require path.resolve __dirname, file
				else
					module.require file
			if not filepath.endsWith \.ls
				filepath += \.ls
			filepath = path.resolve __dirname, filepath
			code = fs.readFileSync filepath, \utf8
			code = livescript.compile code
			code
