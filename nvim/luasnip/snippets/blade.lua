return {

	-- -----------------------------------------------------------------------
	-- echo
	-- -----------------------------------------------------------------------

	s_inline("e", { 
		t("{{ "),
		i(0, ""),
		t(" }}"),
	}),

	s_inline("ee", { 
		t("{!! $"),
		i(0, "value"),
		t(" !!}"),
	}),

	-- -----------------------------------------------------------------------
	-- if
	-- -----------------------------------------------------------------------
	
	s("if", fmt([[
	@if ({condition})
		{body}
	@endif
	]], {
		condition = i(1, "condition"),
		body = i(0),
	})),
	
	-- -----------------------------------------------------------------------
	-- foreach
	-- -----------------------------------------------------------------------

	s("foreach", fmt([[
	@foreach (${items} as ${item})
		{body}
	@endforeach
	]], {
		items = i(1, "items"),
		item = i(2, "item"),
		body = i(0),
	})),
	
	-- -----------------------------------------------------------------------
	-- layout
	-- -----------------------------------------------------------------------

	s("ext", { 
		t("@extends('"),
		i(0, "layouts.name"),
		t("')"),
	}),

	s("inc", { 
		t("@include('"),
		i(0, "views.name"),
		t("')"),
	}),
	
	s("yld", { 
		t("@yield('"),
		i(1, "section"),
		t("')"),
	}),
	
	s("sec", fmt([[
	@section('{name}')
		{body}
	@endsection
	]], {
		name = i(1, "name"),
		body = i(0),
	})),
	
	s("auth", fmt([[
	@auth
		{body}
	@endauth
	]], {
		body = i(0),
	})),
	
	s("com", { 
		t("<x-"),
		i(0, "component-name"),
		t("/>"),
	}),

}
