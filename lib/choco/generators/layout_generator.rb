module Choco
  class LayoutGenerator < Thor::Group
    include Thor::Actions
    
    def self.source_root
      File.dirname(__FILE__)
    end
    
    desc 'Generates a Choco layout'
    argument :name
    
    def create_model_file
      @layout_name = name.camelcase.singularize
      @name = name.underscore.singularize
      template('templates/views/layout.js', "app/views/layouts/#{@name}.js")
    end
    
  end
end
