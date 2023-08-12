return {
		
	-- -----------------------------------------------------------------------
	-- console log
	-- -----------------------------------------------------------------------

	s("cl", fmt([[
	console.log({});
	]], {
		i(1)
	})),

	s("pp", fmt([[
	console.log('{name}', {output});
	]], {
		name = rep(1),
		output = i(1)
	})),

	-- -----------------------------------------------------------------------
	-- function
	-- -----------------------------------------------------------------------

	s("fun", fmt([[
	function {name}({args}) {{
		{body}
	}}
	]], {
		name = i(1, "functionName"),
		args = i(2, "arguments"),
		body = i(0, "//")
	})),

	s_inline("fn", fmt([[
	{args} => {{
		{body}
	}}
	]], {
		args = c(1, {
			sn(nil, {
				t("("),
				i(1, "args"),
				t(")")
			}),
			i(1, "args"),
		}),
		body = i(0, "//")
	})),
	

	-- -----------------------------------------------------------------------
	-- if/else
	-- -----------------------------------------------------------------------

	s("if", fmt([[
	if ({condition}) {{
		{body}
	}}
	]], {
		condition = i(1, "condition"),
		body = i(0, "//")
	})),

	s("else", fmt([[
	else {{
		{body}
	}}
	]], {
		body = i(0, "//")
	})),

	-- -----------------------------------------------------------------------
	-- class
	-- -----------------------------------------------------------------------

	s("class", fmt([[
	class {name} {{
		constructor() {{
			{body}
		}}
	}}
	]], {
		name = i(1, "ClassName"),
		body = i(0, "//")
	})),

	s("met", fmt([[
	{visibility}{name}({args}) {{
		{body}
	}}
	]], {
		name = i(1, "myMethod"),
		args = i(2),
		visibility = c(3, {
			t(""),
			t("public "),
			t("protected "),
			t("private "),
		}),
		body = i(0, "//")
	})),

	s("get", fmt([[
	get {name}() {{
		{body}
	}}
	]], {
		name = i(1, "myGetter"),
		body = i(0, "//")
	})),

	s("set", fmt([[
	set {name}({args}) {{
		this.{member} = {mval};
	}}
	]], {
		name = i(1, "mySetter"),
		args = i(2, "value"),
		member = rep(2),
		mval = rep(2),
	})),

	s("prom", {
		t("new Promise("),
		i(0),
		t(")")
	}),

	-- -----------------------------------------------------------------------
	-- import
	-- -----------------------------------------------------------------------
	
	s("imp", {
		t("import "),
		c(1, {
			sn(nil, {
				t("{ "),
				i(1, "BaseClass"),
				t(" }"),
			}),
			i(1, "BaseClass"),
		}),
		t(" from '"),
		i(2, "BaseClass"),
		t("';"),
	}),

	-- -----------------------------------------------------------------------
	-- export
	-- -----------------------------------------------------------------------
	
	s("exp", {
		t("export default "),
		i(1, "data"),
		t(";"),
	}),

	-- -----------------------------------------------------------------------
	-- constant / let
	-- -----------------------------------------------------------------------

	s("con", {
		t("const "),
		i(1, "name"),
		t(" = "),
		i(2, "data"),
		t(";"),
	}),

	-- -----------------------------------------------------------------------
	-- return
	-- -----------------------------------------------------------------------

	s("ret", {
		t("return "),
		i(0),
		t(";"),
	}),

	s("ret1", t("return true;")),
	s("ret0", t("return false;")),

	-- -----------------------------------------------------------------------
	-- comment bar
	-- -----------------------------------------------------------------------

	s("bar", fmt([[
	/* {line} */
	/*  {title}  */
	/* {line} */
	]], {
		title = i(1),
		line = f(function(args, snip)
			return string.rep("-", args[1][1]:len() + 2) end, 1
		),
	})),
}
