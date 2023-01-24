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
		args = i(2, "args"),
		body = i(0, ""),
	})),

}
