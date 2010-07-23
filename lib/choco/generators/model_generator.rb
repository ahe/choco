module Choco
  class ModelGenerator < Thor::Group
    include Thor::Actions
    
    def self.source_root
      File.dirname(__FILE__)
    end
    
    desc 'Generates a Choco model'
    argument :name
    
    def create_model_file
      @model_name = name.camelcase.singularize
      @model = name.underscore.singularize
      @route_path = name.underscore.pluralize
      template('templates/models/base.js', "app/models/#{@model}.js")
    end
    
  end
end
