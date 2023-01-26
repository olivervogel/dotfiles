return {

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

	s("def", fmt([[
	def {name}({args}) do
		{body}
	end
	]], {
		name = i(1, "my_function"),
		args = i(2, ""),
		body = i(0, ""),
	})),

	s("if", fmt([[
	if {condition} do
		{body}
	end
	]], {
		condition = i(1, "condition"),
		body = i(0, ""),
	})),

	s("ifelse", fmt([[
	if {condition} do
		{body}
	else
		# ...
	end
	]], {
		condition = i(1, "condition"),
		body = i(0, ""),
	})),

	s("=>", sn(1, {
		t("\""),
		i(1, "key"),
		t("\" => "),
		d(2, function(args)
			return sn(nil, {
				i(1, args[1])
			})
		end, {1}),
		t(""),
	})),


}, {

	s(">>", { 
		t("|> ")
	}),

}
