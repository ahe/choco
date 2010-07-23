require 'open-uri'
require 'json'

module Choco
  class ScaffoldGenerator < Thor::Group
    include Thor::Actions
    
    def self.source_root
      File.dirname(__FILE__)
    end
    
    desc 'Generates a Choco CRUD controller with views & model'
    argument :name, :required => true
    argument :fields, :type => :array, :default => []
    
    def get_data_structure
      @controller_name = name.pluralize.camelcase
      @route_path = name.pluralize.underscore
      @model = name.singularize.underscore
      @model_name = name.singularize.camelcase
      
      @keys = []
      if fields.first && fields.first.include?('http://')
        @keys = load_json(fields.first)
      else
        @keys = fields
      end
    end
    
    def create_controller
      template('templates/controllers/rest_controller.js', "app/controllers/#{@route_path}_controller.js")
    end
    
    def create_views
      empty_directory "app/views/#{@route_path}"
      template('templates/views/index.template', "app/views/#{@route_path}/index.template")
      template('templates/views/show.template', "app/views/#{@route_path}/show.template")
      template('templates/views/new.template', "app/views/#{@route_path}/new.template")
      template('templates/views/edit.template', "app/views/#{@route_path}/edit.template")
    end
    
    def create_model
      template('templates/models/base.js', "app/models/#{@model}.js")        
    end
    
    private
    
    def load_json(url)
      begin
        buffer = open(url, 'UserAgent' => 'Choco').read
        data = JSON.parse(buffer)[0]
      
        if data.size == 1 && data.first[1].is_a?(Hash)
          data = data.first[1]
        end
      
        keys = data.map{ |key, value| key }
      rescue Exception
        puts "An error occured (check that your URL is reachable and that your JSON is not empty)"
      end
      keys
    end
    
  end
end
