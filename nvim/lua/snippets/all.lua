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
	-- cron
	-- -----------------------------------------------------------------------

	s("cron", { 
		t("* * * * * "),
		t("cd /path-to-your-project && php artisan schedule:run >> /dev/null 2>&1"),
	}),

	-- -----------------------------------------------------------------------
	-- command templates
	-- -----------------------------------------------------------------------

	s("cmd_curl", { 
		t({"curl -X POST \\", ""}),
      t({"-H \"Accept: text/markdown\" \\", ""}),
      t({"-d '{\"key\": \"value\"}' \\", ""}),
      t({"-u \"user:password\" \\", ""}),
		t("https://"),
		i(1, "example.com"),
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

	s("cmd_rsync", { 
		t("rsync -av --delete"),
		t(" "),
		i(1, "/local/folder"),
		t("/ "),
		i(2, "remote.host"),
		t(":/"),
		i(3, "folder"),
	}),

	s("cmd_tar", { 
		t("tar -czvf"),
		t(" "),
		i(1, "archive"),
		t(".tar.gz "),
		t("./"),
		i(2, "src"),
		c(3, {
			t(""),
			sn(nil, {
				t(" --exclude \"./"),
				i(1, "folder"),
				t("\""),
			})
      })
	}),

	s("cmd_zip", { 
		t("zip -r"),
		t(" "),
		i(1, "archive"),
		t(".zip "),
		t("./"),
		i(2, "src"),
		c(3, {
			t(""),
			sn(nil, {
				t(" -x \"./"),
				i(1, "folder"),
				t("\""),
			})
      })
	}),

}
