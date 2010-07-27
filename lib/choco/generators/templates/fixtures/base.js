if(app.fixtures) {
	var model = '{ "id": 1, "title": "Hello Choco!" }';
	
	$.mockjax({
	  url: '/<%= @name %>/*',
	  responseText: model
	});
	
	$.mockjax({
	  url: '/<%= @name %>',
		type: 'POST',
	  responseText: model
	});
	
	$.mockjax({
	  url: '/<%= @name %>',
		type: 'GET',
	  proxy: app.project_path + '/fixtures/<%= @name %>/<%= @name %>.json'
	});
}