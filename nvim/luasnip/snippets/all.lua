return {

	s("fox", { 
		t("The quick brown fox jumps over the lazy dog")
	}),

	s("lorem", { 
		t("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
	}),

	s("tt", fmt([[
	function {name}({args}) {{
		{body}
	}}
	]], {
		name = i(1, "myFunction"),
		args = c(2, { t("args"), t("") }, { node_ext_opts = {
			passive = {
				virt_text = {{"args | nil"}}
			}
		}}),
		body = c(3, { t("//"), i(1, "value") }),
	})),

}
