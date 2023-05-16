return {

	-- -----------------------------------------------------------------------
	-- do/end
	-- -----------------------------------------------------------------------

	s("do", fmt([[
		do
			{body}
		end
	]], {
		body = i(0)
	})),

	-- -----------------------------------------------------------------------
	-- with
	-- -----------------------------------------------------------------------

	s("with", fmt([[
		with {statement} <- {fun} do
			{result}
		end
	]], {
		statement = i(1, "{:ok, name}"),
		fun = i(2, "parse_name(params)"),
		result = i(3, "name"),
	})),

	-- -----------------------------------------------------------------------
	-- module
	-- -----------------------------------------------------------------------

	s("mod", fmt([[
	defmodule {name} do
		{doc}

		{body}
	end
	]], {
		name = i(1, "myModule"),
		doc = c(2, {
			t("@moduledoc false"),
			t({
			"@moduledoc \"\"\"",
			"\tDescription",
			"\t\"\"\"",
			})
		}),
		body = i(0, ""),
	})),

	s("mdoc", {
		t({"@moduledoc \"\"\"", ""}),
		i(0),
		t({"", "\"\"\""}),
	}),

	s("typ", {
		t("@type "),
		i(1, "name"),
		t(" :: {"),
		i(2, "type"),
		t("}"),
	}),

	s("spec", {
		t("@spec "),
		i(1, "name"),
		t("("),
		i(2, "argument"),
		t(") :: {"),
		i(3, "return"),
		t("}"),
	}),

	s("call", {
		t("@callback "),
		i(1, "function_name"),
		t("("),
		i(2),
		t(") :: {:ok} | {:error}"),
	}),

	s("beh", {
		t("@behaviour "),
		i(0, "Module"),
	}),

	s("impl", {
		t("@impl "),
		i(0, "Module"),
	}),

	-- -----------------------------------------------------------------------
	-- live view
	-- -----------------------------------------------------------------------

	s("modp", fmt([[
	defmodule {app}Web.{module} do
		@moduledoc false

	  use {app_use}Web, {type}
		{body}
	end
	]], {
		app = i(1, "Foo"),
		app_use = rep(1),
		module = f(function(args, snip)
			local fn = snip.env.TM_FILENAME
			local i, j = string.find(fn, "%.")
			fn = string.sub(fn, 1, j - 1)

			local function title_case_word(s)
				return string.upper(string.sub(s,1,1))..string.sub(s,2)
			end

			local function tocamel(s)
				return (string.gsub(s,"_(%w+)", title_case_word))
			end

			return title_case_word(tocamel(fn))
		end, {}),
		type = c(2, {
			t(":live_view"),
			t(":component"),
			t(":live_component"),
			t(":controller"),
			t(":view"),
		}),
		body = d(3, function(args)
			if args[1][1] == ":live_view" or args[1][1] == ":live_component" then
					return sn(nil, 
						t({
							"",
							"  def render(assigns) do",
							"    ~H\"\"\"",
							"    <div></div>",
							"    \"\"\"",
							"  end",
						})
					)
				elseif args[1][1] == ":controller" then
					return sn(nil, 
						t({
							"",
							"  def index(conn, _params) do",
							"    render(conn, \"index.html\")",
							"  end",
						})
					)
				else
					return sn(nil, {
						t("")
					})
			end
		end, 2),
	})),

	-- -----------------------------------------------------------------------
	-- function
	-- -----------------------------------------------------------------------

	s("def", fmt([[
	def {name}({args}) do
		{body}
	end
	]], {
		name = i(1, "my_function"),
		args = i(2, ""),
		body = i(0),
	})),

	s_inline("fn", {
		t("fn "),
		i(1, "value"),
		t(" -> "),
		i(0),
		t(" end")
	}),

	s("doc", {
		t({"@doc \"\"\"", ""}),
		i(0),
		t({"", "\"\"\""}),
	}),

	-- -----------------------------------------------------------------------
	-- ok tuple
	-- -----------------------------------------------------------------------

	s("ok", {
		t("{:"),
		i(1, "ok"),
		t(", "),
		i(0, "value"),
		t("}"),
	}),
	-- -----------------------------------------------------------------------
	-- function private
	-- -----------------------------------------------------------------------

	s("defp", fmt([[
	defp {name}({args}) do
		{body}
	end
	]], {
		name = i(1, "my_function"),
		args = i(2, ""),
		body = i(0, ""),
	})),

	-- -----------------------------------------------------------------------
	-- if condition
	-- -----------------------------------------------------------------------

	s("if", fmt([[
	if {condition} do
		{body}
	end
	]], {
		condition = i(1, "condition"),
		body = i(0, ""),
	})),

	s("unl", fmt([[
	unless {condition} do
		{body}
	end
	]], {
		condition = i(1, "condition"),
		body = i(0, ""),
	})),

	-- -----------------------------------------------------------------------
	-- ifelse condition
	-- -----------------------------------------------------------------------

	s("ife", fmt([[
	if {condition} do
		{body}
	else
		#
	end
	]], {
		condition = i(1, "condition"),
		body = i(0, ""),
	})),

	-- -----------------------------------------------------------------------
	-- for
	-- -----------------------------------------------------------------------

	s("for", fmt([[
	for {item} <- {items} do
		{body}
	end
	]], {
		item = i(1, "item"),
		items = i(2, "items"),
		body = i(0, ""),
	})),
		
	-- -----------------------------------------------------------------------
	-- case
	-- -----------------------------------------------------------------------

	s("case", fmt([[
	case {target} do
		{body}
		_ -> result
	end
	]], {
		target = i(1, "target"),
		body = i(0, ""),
	})),

	-- -----------------------------------------------------------------------
	-- cond
	-- -----------------------------------------------------------------------

	s("cond", fmt([[
	cond do
		{condition} -> {result}
		true -> false
	end
	]], {
		condition = i(1, "condition"),
		result = i(0, "result"),
	})),

	-- -----------------------------------------------------------------------
	-- each
	-- -----------------------------------------------------------------------

	s("each", fmt([[
	Enum.each(1..{count}, fn {val} ->
		{body}
	end)
	]], {
		count = i(1, "10"),
		val = i(2, "val"),
		body = i(0, ""),
	})),

	-- -----------------------------------------------------------------------
	-- dgettext
	-- -----------------------------------------------------------------------

	s_inline("gt", {
		t("dgettext("),
		t("\""),
		i(2, "group"),
		t("\", \""),
		i(1, "text"),
		t("\")"),
	}),

	-- -----------------------------------------------------------------------
	-- sig
	-- -----------------------------------------------------------------------

	s("sig", fmt([[
	~H"""
	{body}
	"""
	]], {
		body = i(0, ""),
	})),

	-- -----------------------------------------------------------------------
	-- inspect
	-- -----------------------------------------------------------------------

	s("ins", {
		t("IO.inspect("),
		i(0, ""),
		t(")"),
	}),

	s("pp", fmt([[
	IO.inspect("-----------------------------------------------------------------")
	IO.inspect({value})
	IO.inspect("-----------------------------------------------------------------")
	]], {
		value = i(0, ""),
	})),

	-- -----------------------------------------------------------------------
	-- map
	-- -----------------------------------------------------------------------

	s_inline("map", {
		t("%"),
		i(1, ""),
		t("{"),
		i(0, ""),
		t("}"),
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
	-- import
	-- -----------------------------------------------------------------------

	s("imp", {
		t("import "),
		i(1, "Phoenix.HTML"),
		c(2, {
			sn(nil, {
				i(1, ""),
			}),
			sn(nil, {
				t(", only: ["),
				i(1, "raw"),
				t(": "),
				i(2, "1"),
				t("]"),
			}),
		}),
	}),

	-- -----------------------------------------------------------------------
	-- Ecto
	-- -----------------------------------------------------------------------

	s("eqf", {
		t("from("),
		f(function(args, snip)
			return args[1][1]:sub(1, 1):lower() end, 1
		),
		t(" in "),
		i(1, "Item"),
		t(")"),
	}),

	s("eqw", {
		t("where("),
		i(1, "id"),
		t(": "),
		d(2, function(args)
			return sn(nil, {
				-- i(1, "^"),
				c(1, {
					t("^"),
					t(""),
				}),
				i(2, args[1])
			}) end, 1
		),
		t(")"),
	}),

	s("eqo", {
		t("order_by("),
		c(2, {
			t("asc:"),
			t("desc:"),
		}),
		t(" :"),
		i(1, "name"),
		t(")"),
	}),

	s("eqd", {
		t("distinct(["),
		i(1, "i"),
		t("], "),
		rep(1),
		t(".id)"),
	}),

	s("eqj", {
		t("join(:"),
		i(2, "left"),
		t(", ["),
		i(3, "c"),
		t("], "),
		f(function(args, snip)
			return args[1][1]:sub(1, 1):lower() end, 1
		),
		t(" in "),
		i(1, "Item"),
		t(", on: "),
		rep(3),
		t("."),
		f(function(args, snip)
			return args[1][1]:lower() end, 1
		),
		t("_id == "),
		f(function(args, snip)
			return args[1][1]:sub(1, 1):lower() end, 1
		),
		t(".id"),
		t(")"),
	}),

	s("eqs", {
		t("select(["),
		i(1, "i"),
		t("], {"),
		rep(1),
		t("."),
		i(2, "name"),
		t("})"),
	}),

	s("eqg", {
		t("group_by(["),
		i(1, "i"),
		t("], "),
		rep(1),
		t("."),
		i(2, "id"),
		t(")"),
	}),

	s("eqp", {
		t("preload(:"),
		i(1, "items"),
		t(")"),
	}),

	s("eql", {
		t("limit("),
		i(1, "1"),
		t(")"),
	}),
	-- -----------------------------------------------------------------------
	-- repo
	-- -----------------------------------------------------------------------
	
	s("rep", {
		c(1, {
			t("Repo.one()"),
			t("Repo.all()"),
			t("Repo.insert()"),
			t("Repo.insert_all()"),
			t("Repo.update()"),
			t("Repo.update_all()"),
			t("Repo.delete()"),
			t("Repo.delete_all()"),
		})
	}),

	-- -----------------------------------------------------------------------
	-- live view
	-- -----------------------------------------------------------------------

	s("he", fmt([[
	def handle_event("{name}", _params, socket) do
		{{:noreply, socket}}
	end
	]], {
		name = i(0, "event_name"),
	})),

	s("hi", fmt([[
	def handle_info("{name}", socket) do
		{{:noreply, socket}}
	end
	]], {
		name = i(0, "event_name"),
	})),

	s("hp", fmt([[
	def handle_params({params}, _url, socket) do
		{{:noreply, socket}}
	end
	]], {
		params = i(0, "params"),
	})),

	s("mount", fmt([[
	def mount(_params, _session, socket) do
		{{:ok, socket}}
	end
	]], {
	})),

	s("update", fmt([[
	def update(_assigns, socket) do
		{{:ok, socket}}
	end
	]], {
	})),

	s("render", fmt([[
  def render(assigns) do
    ~H"""
			{body}
    """
  end
	]], {
		body = i(0)
	})),

	-- -----------------------------------------------------------------------
	-- assign
	-- -----------------------------------------------------------------------

	s("ass", {
		t("assign("),
		c(3, {
			t(""),
			t("socket, "),
			t("assigns, "),
		}),
		i(1, "name"),
		t(": "),
		d(2, function(args)
			return sn(nil, {
				i(1, args[1])
			})
		end, {1}),
		t(")")
	}),

	s("so", {
		t("socket")
	}),

	s("pm", {
		i(1, "assigns"),
		t(" = "),
		rep(1)
	}),

	-- -----------------------------------------------------------------------
	-- enum
	-- -----------------------------------------------------------------------

	s("enf", {
		t("Enum.filter("),
		i(0),
		t(")")
	}),

	s("enm", {
		t("Enum.map("),
		i(0),
		t(")")
	}),

	s("enc", {
		t("Enum.count("),
		i(0),
		t(")")
	}),

	s("enr", {
		t("Enum.random("),
		i(0),
		t(")")
	}),

	s("ena", {
		t("Enum.at("),
		i(1, "enumerable"),
		t(", "),
		i(0, "0"),
		t(")")
	}),

	-- -----------------------------------------------------------------------
	-- map
	-- -----------------------------------------------------------------------

	s("mpg", {
		t("Map.get("),
		i(0),
		t(")")
	}),

	s("mpk", {
		t("Map.keys("),
		i(0),
		t(")")
	}),

	s("mpp", {
		t("Map.put("),
		i(0),
		t(")")
	}),

	s("mpv", {
		t("Map.values("),
		i(0),
		t(")")
	}),

	-- -----------------------------------------------------------------------
	-- list
	-- -----------------------------------------------------------------------

	s("lsf", {
		t("List.first("),
		i(0),
		t(")")
	}),

	s("lsl", {
		t("List.last("),
		i(0),
		t(")")
	}),

	-- -----------------------------------------------------------------------
	-- string
	-- -----------------------------------------------------------------------

	s("stl", {
		t("String.length("),
		i(0),
		t(")")
	}),

	s("stt", {
		t("String.trim("),
		i(0),
		t(")")
	}),


	-- -----------------------------------------------------------------------
	-- pipe operator
	-- -----------------------------------------------------------------------

	s_inline({trig = "(.*)>>", regTrig = true}, { 
		f(function(args, snip)
			local char_before_trigger = snip.captures[1]:sub(-1)
			if char_before_trigger == " " then
				return snip.captures[1] .. "|> "
			else
				return snip.captures[1] .. " |> "
			end
		end, {})
	}),

	s_inline("&&", {
		t("&(&1"),
		i(0),
		t(")")
	})

}, {

}
