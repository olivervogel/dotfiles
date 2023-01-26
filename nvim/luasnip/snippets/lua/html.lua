return {

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

	s("css", fmt([[
		<link rel="stylesheet" type="text/css" href="{}">
	]], {
		i(1, "app.css")
	})),

	s("js", fmt([[
		<script src="{}"></script>
	]], {
		i(1, "app.js")
	})),

}
