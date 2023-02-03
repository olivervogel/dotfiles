return {
		
	-- -----------------------------------------------------------------------
	-- html
	-- -----------------------------------------------------------------------

	s("html", fmt([[
	<!DOCTYPE html>

	<html>
	<head>
	<meta charset="utf-8">
	<title>untitled</title>
	</head>
	<body>

		{}

	</body>
	</html>
	]], {
		i(1)
	})),

	-- -----------------------------------------------------------------------
	-- css
	-- -----------------------------------------------------------------------

	s("css", fmt([[
		<link rel="stylesheet" type="text/css" href="{}">
	]], {
		i(1, "app.css")
	})),

	-- -----------------------------------------------------------------------
	-- javascript
	-- -----------------------------------------------------------------------

	s("js", fmt([[
		<script src="{}"></script>
	]], {
		i(1, "app.js")
	})),
	
	-- -----------------------------------------------------------------------
	-- tag
	-- -----------------------------------------------------------------------

	s_inline("tag", {
		t("<"),
		i(1, "div"),
		c(2, {
			sn(nil, {
				i(1, ""),
			}),
			sn(nil, {
				t(" class=\""),
				i(1, ""),
				t("\""),
			}),
			sn(nil, {
				t(" id=\""),
				i(1, ""),
				t("\""),
			}),
		}),
		t(">"),
		i(0),
		t("</"),
		rep(1),
		t(">"),
	}),

	-- -----------------------------------------------------------------------
	-- div with empty class attribute
	-- -----------------------------------------------------------------------

	s_inline("div", {
		t("<div>"),
		i(0),
		t("</div>"),
	}),

	s_inline("div.", {
		t("<div class=\""),
		i(1),
		t("\">"),
		i(0),
		t("</div>"),
	}),

	-- -----------------------------------------------------------------------
	-- tag with either id or class attribute (div.foo, div#foo)
	-- -----------------------------------------------------------------------

	s({trig = "(%a%a+)([#%.])([%w_-]+)", regTrig = true}, {
		t("<"),
		f(function(args, snip) return
			snip.captures[1] end, {}),
		f(function(args, snip)
			if snip.captures[2] == "." then
				return " class=\"" .. snip.captures[3] .. "\""
			elseif snip.captures[2] == "#" then
				return " id=\"" .. snip.captures[3] .. "\""
			end
		end, {}),
		t(">"),
		i(0),
		t("</"),
		f(function(args, snip) return
			snip.captures[1] end, {}),
		t(">"),
	}),

	-- -----------------------------------------------------------------------
	-- headers
	-- -----------------------------------------------------------------------
	
	s({trig = "h(%d)", regTrig = true}, {
		t("<h"),
		f(function(args, snip) return
			snip.captures[1] end, {}),
		t(">"),
		i(0),
		t("</h"),
		f(function(args, snip) return
			snip.captures[1] end, {}),
		t(">"),
	}),

	-- -----------------------------------------------------------------------
	-- input
	-- -----------------------------------------------------------------------
	
	s("inp", {
		t("<input type=\""),
		c(1, {
			t("text"),
			t("checkbox"),
			t("hidden"),
			t("radio"),
			t("password"),
			t("number"),
			t("file"),
			t("submit"),
			t("email"),
			t("url"),
			t("date"),
		}),
		t("\""),
		t(" name=\""),
		i(0, ""),
		t("\""),
		t(">"),
	}),

	-- -----------------------------------------------------------------------
	-- form
	-- -----------------------------------------------------------------------

	s("form", fmt([[
	<form method="post">
		{body}
	</form>
	]], {
		body = i(0)
	})),

	-- -----------------------------------------------------------------------
	-- button
	-- -----------------------------------------------------------------------

	s("button", fmt([[
	<button>{body}</button>
	]], {
		body = i(0)
	})),

	-- -----------------------------------------------------------------------
	-- hr
	-- -----------------------------------------------------------------------

	s("hr", {
		t("<hr>")
	}),

	-- -----------------------------------------------------------------------
	-- img
	-- -----------------------------------------------------------------------

	s_inline("img", {
		t("<img src=\""),
		i(1),
		t("\""),
		c(2, {
			sn(nil, {
				t(" width=\""),
				i(1),
				t("\""),
				t(" height=\""),
				i(2),
				t("\""),
			}),
			sn(nil, {
				i(1),
			}),
		}),
		t(">"),
	}),

	-- -----------------------------------------------------------------------
	-- link
	-- -----------------------------------------------------------------------
	
	s_inline("link", {
		t("<a href=\""),
		i(1, "#"),
		t("\">"),
		i(0),
		t("</a>")
	}),

	-- -----------------------------------------------------------------------
	-- comment banner
	-- -----------------------------------------------------------------------
	
	s("bar", fmt([[
	<!-- {line} -->
	<!--  {title}  -->
	<!-- {line} -->
	]], {
		title = i(1),
		line = f(function(args, snip)
			return string.rep("-", args[1][1]:len() + 2) end, 1
		),
	})),

}
