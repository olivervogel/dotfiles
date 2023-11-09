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
		body = i(0, "//")
	})),

	s("prop", {
		c(1, {
			t("protected"),
			t("private"),
			t("public"),
		}),
		t(" $"),
		i(2, "propertyName"),
		t(" = "),
		i(3, "null"),
		t(";"),
	});

	s("const", {
		c(1, {
			t("protected"),
			t("private"),
			t("public"),
		}),
		t(" const "),
		i(2, "CONSTANT_NAME"),
		t(" = '"),
		i(3, "value"),
		t("'"),
		t(";"),
	});


	s("trait", fmt([[
	trait {name}
	{{
		{body}
	}}
	]], {
		name = i(1, "TraitName"),
		body = i(0, "//")
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
	-- interface
	-- -----------------------------------------------------------------------

	s("inter", fmt([[
	interface {name}
	{{
		{body}
	}}
	]], {
		name = i(1, "InterfaceName"),
		body = i(0, "//")
	})),

	-- -----------------------------------------------------------------------
	-- enum
	-- -----------------------------------------------------------------------

	s("enum", fmt([[
	enum {name}{type}
	{{
		case {case_name}{case_value};
	}}
	]], {
		name = i(1, "Name"),
		type = c(2, {
			t(""),
			t(": string"),
			t(": int"),
		}),
		case_name = i(0, "DRAFT"),
		case_value = f(function(args, snip)
			if args[1][1] == ": string" then
				return " = 'draft'"
			elseif args[1][1] == ": int" then
				return " = 1"
			end
			return args[1][1]
		end, 2),
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
	-- require / include
	-- -----------------------------------------------------------------------

	s("req", {
		t("require '"),
		i(0),
		t("';"),
	}),

	s("inc", {
		t("include '"),
		i(0),
		t("';"),
	}),

	-- -----------------------------------------------------------------------
	-- attribute
	-- -----------------------------------------------------------------------

	s("att", {
		t("#["),
		i(0, 'Attribute'),
		t("]"),
	}),


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
		body = i(0, "//"),
	})),

	s("for", fmt([[
	for (${var1} = 0; ${var2} < {count}; ${var3}++) {{
		{body}
	}}
	]], {
		var1 = i(1, "i"),
		var2 = rep(1),
		var3 = rep(1),
		count = i(2, "9"),
		body = i(0, "//"),
	})),


	-- -----------------------------------------------------------------------
	-- try/catch
	-- -----------------------------------------------------------------------

	s("try", fmt([[
	try {{
		{body}
	}} catch (Exception $e) {{
		# code ...
	}}
	]], {
		body = i(0, '//'),
	})),


	s("tr", fmt([[
	throw new {name}Exception('{message}');
	]], {
		name = i(1, "Custom"),
		message = i(0, "Division by zero."),
	})),

	-- -----------------------------------------------------------------------
	-- switch
	-- -----------------------------------------------------------------------

	s("switch", fmt([[
	switch ({var}) {{
		case 'value':
			// code
			break;

		default:
			// code
			break;
	}}
	]], {
		var = i(0, "variable"),
	})),

	-- -----------------------------------------------------------------------
	-- match
	-- -----------------------------------------------------------------------

	s("match", fmt([[
	match ({var}) {{
		{case} => '{return_value}',
		default => '{default_return_value}',
	}};
	]], {
		var = i(1, "variable"),
		case = i(2, "case"),
		return_value = i(3, "value"),
		default_return_value = i(0, "value"),
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

	s("retn", {
		t("return null;"),
	}),

	s("rett", {
		t("return $"),
		i(1, "this"),
		i(0),
		t(";")
	}),

	s("reta", {
		t("return ["),
		i(1),
		t("];")
	}),

	-- -----------------------------------------------------------------------
	-- use
	-- -----------------------------------------------------------------------

	s("use", {
		t("use "),
		i(0, "TraitName"),
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
		t("'"),
		i(1, "key"),
		t("' => "),
		c(2, {
			d(nil, function(args)
				return sn(nil, {
					t('$'),
					i(1, args[1])
				})
			end, {1}),
			sn(nil, {
				t("'"),
				i(1, ""),
				t("'"),
			}),
			sn(nil, {
				t("["),
				i(1, ""),
				t("]"),
			}),
			t("")
		})
	})),

	-- -----------------------------------------------------------------------
	-- error reporting
	-- -----------------------------------------------------------------------

	s("err", fmt([[
	error_reporting(E_ALL ^ E_NOTICE);
	ini_set('display_errors', true);
	]], {})),

	-- -----------------------------------------------------------------------
	-- return true
	-- -----------------------------------------------------------------------

	s("ret1", t("return true;")),

	-- -----------------------------------------------------------------------
	-- return false
	-- -----------------------------------------------------------------------

	s("ret0", t("return false;")),

	-- -----------------------------------------------------------------------
	-- return null
	-- -----------------------------------------------------------------------

	s("retn", t("return null;")),

	-- -----------------------------------------------------------------------
	-- array
	-- -----------------------------------------------------------------------

	s_inline("arr", {
		t("["),
		i(0),
		t("]"),
	}),

	-- -----------------------------------------------------------------------
	-- doc block
	-- -----------------------------------------------------------------------

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


	s("doci", fmt([[
	/**
	 * {{@inheritdoc}}
	 *
	 * @see {see}
	 */
	]], {
		see = i(1, "Interface::function()"),
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
	var_dump({output});
	echo "</pre>";
	exit;
	]], {
		-- output = i(1, "$data"),
		output = c(1, {
			d(nil, function(args)
				return sn(nil, {
					t('$'),
					i(1, "var")
				})
			end),
			sn(nil, {
				t("\""),
				i(1, "text"),
				t("\""),
			}),
			t("")
		})
	})),

	-- -----------------------------------------------------------------------
	-- heredoc block
	-- -----------------------------------------------------------------------

	s("block", fmt([[
	<<<{istart}
	{content}
	{iend};
	]], {
		istart = i(1, "IDENT"),
		iend = rep(1),
		content = i(0),
	})),

}
