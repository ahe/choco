<%= @controller_name %>Controller = function(app) { with(app) {
	
	/** Routes **/
	
	// GET index
	get('#/<%= @route_path %>', function(cx) {
		cx.<%= @model.pluralize %> = <%= @model_name %>.all();
	});
	
	// GET new
	get('#/<%= @route_path %>/new', function(cx) {
	});
	
	// POST create
	post('#/<%= @route_path %>', function(cx) {
		var <%= @model %> = new <%= @model_name %>(cx.params['<%= @model %>']);
		<%= @model %>.save(function(success) {
			cx.redirect('#/<%= @route_path %>/' + <%= @model %>.id());
		});
	});
	
	// GET edit
	get('#/<%= @route_path %>/edit/:id', function(cx) {
		cx.<%= @model %> = <%= @model_name %>.find(cx.params['id']);
	});
	
	// PUT update
	put('#/<%= @route_path %>/update/:id', function(cx) {
		var <%= @model %> = <%= @model_name %>.find(cx.params['id']);
		<%= @model %>.update(cx.params['<%= @model %>']).save(function(success) {
			cx.redirect('#/<%= @route_path %>/' + <%= @model %>.id())
		});
	});
	
	// DELETE destroy
	route('delete', '#/<%= @route_path %>/:id', function(cx) {
		var <%= @model %> = <%= @model_name %>.find(cx.params['id']);
		<%= @model %>.destroy();
		cx.trigger('<%= @model %>_remove', { <%= @model %>_id: <%= @model %>.id() });		
	});
	
	// GET show
	get('#/<%= @route_path %>/:id', function(cx) {
		cx.<%= @model %> = <%= @model_name %>.find(cx.params['id']);
	});
	
	/** Events **/
	
	bind('<%= @model %>_remove', function(e, data) {
		$('#<%= @model %>_' + data['<%= @model %>_id']).remove();
	});
	
}};