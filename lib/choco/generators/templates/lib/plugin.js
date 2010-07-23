// js-model plugin
// It allows you to add methods to all your models.

var <%= @plugin_name %>Plugin = {
	modelsClassMethods : {
		myhelper: function() {
			alert('hello world [class method]');
		}
	},
	
	modelsInstanceMethods : {
		myhelper: function() {
			alert('hello world [instance method]');
		}
	}
};

// Apply the js-model plugin
ChocoUtils.modelPlugin(<%= @plugin_name %>Plugin);


// Sammy plugin
// It allows you to add helper methods to your controllers and your views.

(function($) {
  
  Sammy = Sammy || {};
  
  Sammy.<%= @plugin_name %> = function() {
    
    this.helper('<%= @plugin_name.underscore %>', function() {
			alert('hello world [sammy plugin]');
    });
    
  };
  
})(jQuery);

// Add this line to your application_controller.js to use this plugin :
// this.use(Sammy.<%= @plugin_name %>);