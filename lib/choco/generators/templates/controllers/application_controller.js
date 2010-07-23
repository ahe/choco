var app = $.sammy(function() {
	
	this.element_selector = '#choco';
	this.template_engine = 'template';
	
	// Configure your Sammy JS plugins
	this.use(Sammy.Template);
	this.use(Sammy.NestedParams);
	this.use(Sammy.SmartRenderer, '/<%= name %>/app/views/');
	
	// Event fired by the render() method
	this.bind('template_loaded', function(e, data) {
		ChocoUtils.activateDeleteLinks(app);
	});
	
	// Root page
	this.get('#/main', function(cx) {
	});
	
	/* Configure your helpers here */
	this.helpers(ApplicationHelper);
	
	/* Configure your controllers here ### Don't remove this line! */
	// PostsController(this);
});

$(function() {
	// Load your models here, example : var models = [Post, Category]
	var models = [];
	ChocoUtils.loadModels(models, function() {
		app.run('#/main');
	});
});