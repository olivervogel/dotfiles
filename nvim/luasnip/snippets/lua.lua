return {

	s("bar", fmt([[
	-- {line}
	-- {title}
	-- {line}
	]], {
		title = i(1),
		line = f(function(args, snip)
			return string.rep("-", args[1][1]:len()) end, 1
		),
	})),

}
