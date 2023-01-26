return {

	s("e", fmt([[
	<%= {value} %>
	]], {
		value = i(0),
	})),

	s("for", fmt([[
	<%= for {item} <- {items} do %>
		{body}
	<% end %>
	]], {
		item = i(1, "item"),
		items = i(2, "items"),
		body = i(0),
	})),

}
