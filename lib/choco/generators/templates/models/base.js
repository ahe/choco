var <%= @model_name %> = Model("<%= @model %>", {
	persistence: Model.RestPersistence("/<%= @route_path %>"),
	
	// Class methods
}, {
	// Instance methods
});