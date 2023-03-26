return {

	-- -----------------------------------------------------------------------
	-- namespace
	-- -----------------------------------------------------------------------

	s("ns", fmt([[
	namespace {name};
	]], {
		name = i(1, "Namespace"),
	})),

	-- -----------------------------------------------------------------------
	-- class
	-- -----------------------------------------------------------------------

	s("class", fmt([[
	class {name}{extends}
	{{
		{body}
	}}
	]], {
		name = i(1, "ClassName"),
		extends = c(2, {
			sn(nil, {
				t(" extends "),
				i(1, "BaseClass"),
			}),
			t("")
		}),
		body = i(0)
	})),

	-- -----------------------------------------------------------------------
	-- constructor
	-- -----------------------------------------------------------------------

	s("constr", fmt([[
	public function __construct({args})
	{{
		{body}
	}}
	]], {
		args = i(1, ""),
		body = i(0, "//")
	})),

	-- -----------------------------------------------------------------------
	-- function
	-- -----------------------------------------------------------------------

	s("fun", fmt([[
	{visibility} function {name}({args}): {ret}
	{{
		{body}
	}}
	]], {
		visibility = c(1, {
			t("public"),
			t("protected"),
			t("private"),
		}),
		name = i(2, "functionName"),
		args = i(3, ""),
		ret = i(4, "void"),
		body = i(0, "//")
	})),

	-- -----------------------------------------------------------------------
	-- callback function
	-- -----------------------------------------------------------------------

	s_inline("fn", {
		t("function ("),
		i(1, ""),
		t(") {"),
		i(0, ""),
		t("}"),
	}),
	
	-- -----------------------------------------------------------------------
	-- if
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
	-- foreach
	-- -----------------------------------------------------------------------

	s("foreach", fmt([[
	foreach (${items} as {item}) {{
		{body}
	}}
	]], {
		items = i(1, "items"),
		item = c(2, {
			sn(nil, {
				t("$"),
				i(1, "item")
			}),
			sn(nil, {
				t("$"),
				i(1, "key"),
				t(" => $"),
				i(2, "value"),
			})
		}),
		body = i(0, "# code"),
	})),

	-- -----------------------------------------------------------------------
	-- try/catch
	-- -----------------------------------------------------------------------

	s("try", fmt([[
	try {{
		{body}
	}} catch(Exception $e) {{
		# code ...
	}}
	]], {
		body = i(0, "//"),
	})),


	s("tr", fmt([[
	throw new {name}("{message}");
	]], {
		name = i(1, "Expection"),
		message = i(0, "Division by zero."),
	})),


	-- -----------------------------------------------------------------------
	-- this
	-- -----------------------------------------------------------------------

	s_inline("->", {
		t("$"),
		i(1, "this"),
		t("->"),
		i(0, ""),
	}),

	-- -----------------------------------------------------------------------
	-- return
	-- -----------------------------------------------------------------------

	s("ret", {
		t("return "),
		i(0),
		t(";")
	}),

	-- -----------------------------------------------------------------------
	-- echo
	-- -----------------------------------------------------------------------

	s("e", {
		t("echo "),
		i(0),
		t(";")
	}),

	s("spr", {
		t("sprintf(\""),
		i(1, "value"),
		t("\", $"),
		i(2, "var"),
		t(");")
	}),

	-- -----------------------------------------------------------------------
	-- string key
	-- -----------------------------------------------------------------------

	s_inline("=>", sn(1, {
		t("\""),
		i(1, "key"),
		t("\" => "),
		d(2, function(args)
            return sn(nil, {
                i(1, args[1])
            })
        end, {1}),
	})),

	-- -----------------------------------------------------------------------
	-- return true
	-- -----------------------------------------------------------------------

	s("ret1", t("return true;")),

	-- -----------------------------------------------------------------------
	-- return false
	-- -----------------------------------------------------------------------

	s("ret0", t("return false;")),

	s("doc", fmt([[
	/**
	 * {title}
	 *
	 * @param  string $var
	 * @return {ret_value}
	 */
	]], {
		title = i(1, "Title"),
		ret_value = i(2, "void")
	})),

	-- -----------------------------------------------------------------------
	-- comment banner
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

	-- -----------------------------------------------------------------------
	-- pre print
	-- -----------------------------------------------------------------------
	
	s("pp", fmt([[
	echo "<pre>";
	var_dump(${var})
	echo "</pre>";
	exit;
	]], {
		var = i(1, "data"),
	})),
}
