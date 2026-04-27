return {

	-- -----------------------------------------------------------------------
	-- php tag
	-- -----------------------------------------------------------------------

	s("php", { 
		t({
			"<?php",
			"",
			"declare(strict_types=1);",
			"",
			"",
		}),
		t("namespace "),
		i(1, "MyNamespace"),
		t(";"),
	}),

	-- -----------------------------------------------------------------------
	-- fox placeholder text
	-- -----------------------------------------------------------------------

	s("fox", { 
		t("The quick brown fox jumps over the lazy dog")
	}),

	-- -----------------------------------------------------------------------
	-- lorem placeholder text
	-- -----------------------------------------------------------------------

	s("lorem", { 
		t("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
	}),

	-- -----------------------------------------------------------------------
	-- command templates
	-- -----------------------------------------------------------------------

	s("cmd_curl", { 
		t({"curl -X POST \\", ""}),
		c(1, {
			t({"-H \"Accept: text/markdown\" \\", ""}),
			t(""),
		}),
		c(2, {
			t({"-d '{\"key\": \"value\"}' \\", ""}),
			t(""),
		}),
		t("https://"),
		i(3, "example.com"),
	}),

	s("cmd_agee", { 
		t("age -e -R ~/.passage/recipients "),
		i(1, "secret.txt"),
		t(' > '),
		rep(1),
		t('.age'),
	}),

	s("cmd_aged", { 
		t("age -d -i ~/.passage/identities "),
		i(1, "secret.txt.age"),
		t(' > '),
		t('secret.txt'),
	}),

}
